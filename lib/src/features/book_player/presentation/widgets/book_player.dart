import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/page_flip/page_flip.dart';
import 'package:pdfrx/pdfrx.dart';
import '../../../home/domain/book.dart';
import 'book_player_controls.dart';

class BookPlayer extends StatefulWidget {
  final Book book;
  final bool isFullscreen;
  final VoidCallback onToggleFullscreen;

  const BookPlayer({
    super.key,
    required this.book,
    required this.isFullscreen,
    required this.onToggleFullscreen,
  });

  @override
  State<BookPlayer> createState() => _BookPlayerState();
}

class _BookPlayerState extends State<BookPlayer> {
  final _pageFlipController = GlobalKey<PageFlipWidgetState>();
  int _currentPage = 0;
  int _totalPages = 0;
  Future<PdfDocument>? _pdfFuture;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  @override
  void didUpdateWidget(BookPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.book.fileUrl != oldWidget.book.fileUrl) {
      _loadPdf();
    }
  }

  void _loadPdf() {
    if (widget.book.fileUrl != null) {
      _pdfFuture = PdfDocument.openUri(Uri.parse(widget.book.fileUrl!));
    }
  }

  bool _isPdfBook() {
    // Check explicit type first
    if (widget.book.type == 'pdf') return true;
    
    // Infer from fileUrl extension
    final fileUrl = widget.book.fileUrl;
    if (fileUrl != null) {
      final lowerUrl = fileUrl.toLowerCase();
      // Remove query params before checking extension
      final urlWithoutParams = lowerUrl.split('?').first;
      if (urlWithoutParams.endsWith('.pdf')) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isPdf = _isPdfBook();
    print('BookPlayer: type=${widget.book.type}, fileUrl=${widget.book.fileUrl}, isPdf=$isPdf');
    
    if (isPdf && widget.book.fileUrl != null) {
      print('Loading PDF from: ${widget.book.fileUrl}');
      
      return FutureBuilder<PdfDocument>(
        future: _pdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error loading PDF: ${snapshot.error}'));
          }
          final document = snapshot.data!;
          
          final pageCount = document.pages.length;
          if (_totalPages != pageCount) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _totalPages = pageCount;
                });
              }
            });
          }

          final pageFlipWidget = PageFlipWidget(
            key: _pageFlipController,
            backgroundColor: const Color(0xFFF2DCB1),
            initialIndex: _currentPage,
            onPageFlipped: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            lastPage: Container(
              color: const Color(0xFFF2DCB1),
              child: const Center(
                child: Text('The End', style: TextStyle(fontFamily: 'Serif', fontSize: 24)),
              ),
            ),
            children: [
              for (var i = 0; i < document.pages.length; i++) 
                Container(
                  color: const Color(0xFFF2DCB1),
                  child: Center(
                    child: PdfPageView(
                      document: document,
                      pageNumber: i + 1,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
            ],
          );

          final controls = BookPlayerControls(
            title: widget.book.title,
            author: widget.book.author,
            currentPage: _currentPage,
            totalPages: _totalPages > 0 ? _totalPages : 1,
            onNextPage: () {
              if (_currentPage < _totalPages - 1) {
                _pageFlipController.currentState?.nextPage();
              }
            },
            onPrevPage: () {
              if (_currentPage > 0) {
                _pageFlipController.currentState?.previousPage();
              }
            },
            onToggleFullscreen: widget.onToggleFullscreen,
            isFullscreen: widget.isFullscreen,
            onPageChange: (page) {
              if (page >= 0 && page < _totalPages) {
                _pageFlipController.currentState?.goToPage(page);
              }
            },
          );
          
          // If fullscreen, show just the page flip widget
          if (widget.isFullscreen) {
            return Stack(
              children: [
                pageFlipWidget,
                controls,
              ],
            );
          }
          
          // Card view with page flip
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PDF Viewer Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.5),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 9 / 12, // Portrait aspect ratio for books
                      child: Stack(
                        children: [
                          pageFlipWidget,
                          controls,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Book metadata section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.book.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Author info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            backgroundImage: widget.book.uploader?.image != null
                                ? CachedNetworkImageProvider(widget.book.uploader!.image!)
                                : null,
                            child: widget.book.uploader?.image == null
                                ? Text(
                                    (widget.book.uploader?.name ?? widget.book.author)
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.book.uploader?.name ?? widget.book.author,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  '1 subscribers',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          // Subscribe button
                          FilledButton(
                            onPressed: () {},
                            child: const Text('Subscribe'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Action buttons
                      Row(
                        children: [
                          _ActionButton(
                            icon: Icons.thumb_up_outlined,
                            label: '1',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _ActionButton(
                            icon: Icons.thumb_down_outlined,
                            label: 'Dislike',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _ActionButton(
                            icon: Icons.share_outlined,
                            label: 'Share',
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                          _ActionButton(
                            icon: Icons.download_outlined,
                            label: 'Download',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Views and description
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.book.views} views',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'A Tale of Betrayal and Redemption',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Text book implementation
      return Center(
        child: Text(
          'Text book content: ${widget.book.content ?? "No content"}',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
