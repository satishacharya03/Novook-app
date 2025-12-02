import 'dart:async';
import 'package:flutter/material.dart';

class BookPlayerControls extends StatefulWidget {
  final String title;
  final String author;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPage;
  final VoidCallback onPrevPage;
  final VoidCallback onToggleFullscreen;
  final bool isFullscreen;
  final Function(int) onPageChange;
  final VoidCallback? onBack;

  const BookPlayerControls({
    super.key,
    required this.title,
    required this.author,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPage,
    required this.onPrevPage,
    required this.onToggleFullscreen,
    required this.isFullscreen,
    required this.onPageChange,
    this.onBack,
  });

  @override
  State<BookPlayerControls> createState() => _BookPlayerControlsState();
}

class _BookPlayerControlsState extends State<BookPlayerControls> {
  bool _isVisible = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  void _showControls() {
    setState(() {
      _isVisible = true;
    });
    _startHideTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showControls,
      behavior: HitTestBehavior.translucent,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: IgnorePointer(
          ignoring: !_isVisible,
          child: Stack(
            children: [
              // Top Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: widget.onBack ?? () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.author,
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white),
                          onPressed: () {
                            // Settings functionality placeholder
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: widget.isFullscreen ? 8 : 4,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Progress Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 14,
                              ),
                              activeTrackColor: const Color(0xFF3B82F6),
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                              thumbColor: const Color(0xFF3B82F6),
                              overlayColor: const Color(0xFF3B82F6).withOpacity(0.3),
                            ),
                            child: Slider(
                              value: widget.currentPage.toDouble(),
                              min: 0,
                              max: (widget.totalPages - 1).toDouble(),
                              onChanged: (value) {
                                widget.onPageChange(value.round());
                                _showControls();
                              },
                            ),
                          ),
                        ),
                        
                        // Controls Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Previous Button
                            IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: widget.currentPage == 0 
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                size: widget.isFullscreen ? 32 : 24,
                              ),
                              onPressed: widget.currentPage == 0 ? null : widget.onPrevPage,
                            ),
                            
                            const SizedBox(width: 24),
                            
                            // Page Counter
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Text(
                                '${widget.currentPage + 1} / ${widget.totalPages}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: widget.isFullscreen ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 24),
                            
                            // Next Button
                            IconButton(
                              icon: Icon(
                                Icons.chevron_right,
                                color: widget.currentPage == widget.totalPages - 1
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                                size: widget.isFullscreen ? 32 : 24,
                              ),
                              onPressed: widget.currentPage == widget.totalPages - 1 
                                  ? null 
                                  : widget.onNextPage,
                            ),
                            
                            const Spacer(),
                            
                            // Fullscreen Toggle
                            IconButton(
                              icon: Icon(
                                widget.isFullscreen 
                                    ? Icons.fullscreen_exit 
                                    : Icons.fullscreen,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: widget.onToggleFullscreen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
