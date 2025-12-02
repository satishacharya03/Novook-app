import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/data/book_repository.dart';
import '../../home/domain/book.dart';
import 'widgets/book_player.dart';

class BookPlayerScreen extends ConsumerStatefulWidget {
  final Book book;

  const BookPlayerScreen({super.key, required this.book});

  @override
  ConsumerState<BookPlayerScreen> createState() => _BookPlayerScreenState();
}

class _BookPlayerScreenState extends ConsumerState<BookPlayerScreen> {
  bool _isFullscreen = false;

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch full book details to get fileUrl and other fields
    final bookDetailsAsync = ref.watch(bookDetailsProvider(widget.book.id));

    return Scaffold(
      body: bookDetailsAsync.when(
        data: (fullBook) => BookPlayer(
          book: fullBook,
          isFullscreen: _isFullscreen,
          onToggleFullscreen: _toggleFullscreen,
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error loading book',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
