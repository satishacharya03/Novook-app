import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import '../features/home/domain/book.dart';
import '../features/library/data/bookmarks_repository.dart';
import '../features/social/data/social_repository.dart';
import '../features/auth/presentation/auth_controller.dart';

class BookActionsSheet extends ConsumerWidget {
  final Book book;

  const BookActionsSheet({super.key, required this.book});

  static void show(BuildContext context, Book book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BookActionsSheet(book: book),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final bookmarkState = ref.watch(bookmarkStateProvider);
    final likeState = ref.watch(likeStateProvider);

    final isBookmarked = bookmarkState.value?.contains(book.id) ?? false;
    final isLiked = likeState.contains(book.id);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Book info header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: book.coverUrl != null
                      ? Image.network(book.coverUrl!, fit: BoxFit.cover)
                      : Center(
                          child: Text(
                            book.title.substring(0, 1).toUpperCase(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.author,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Quick action buttons row (like YouTube)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuickActionButton(
                  icon: isLiked ? LucideIcons.heart : LucideIcons.heart,
                  label: 'Like',
                  isActive: isLiked,
                  onTap: () {
                    if (!isLoggedIn) {
                      _showLoginRequired(context);
                      return;
                    }
                    ref.read(likeStateProvider.notifier).toggleLike(book.id);
                  },
                ),
                _QuickActionButton(
                  icon: isBookmarked ? LucideIcons.bookmark : LucideIcons.bookmark,
                  label: 'Save',
                  isActive: isBookmarked,
                  onTap: () {
                    if (!isLoggedIn) {
                      _showLoginRequired(context);
                      return;
                    }
                    ref.read(bookmarkStateProvider.notifier).toggleBookmark(book.id);
                  },
                ),
                _QuickActionButton(
                  icon: LucideIcons.share2,
                  label: 'Share',
                  onTap: () => _shareBook(context),
                ),
                _QuickActionButton(
                  icon: LucideIcons.download,
                  label: 'Download',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Download feature coming soon!')),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          // More options
          ListTile(
            leading: const Icon(LucideIcons.listPlus),
            title: const Text('Add to playlist'),
            onTap: () {
              if (!isLoggedIn) {
                _showLoginRequired(context);
                return;
              }
              Navigator.pop(context);
              _showAddToPlaylistDialog(context, ref);
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.link),
            title: const Text('Copy link'),
            onTap: () {
              Clipboard.setData(ClipboardData(
                text: 'https://novook.vercel.app/book/${book.id}',
              ));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied to clipboard')),
              );
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.flag),
            title: const Text('Report'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Report feature coming soon')),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _shareBook(BuildContext context) {
    Navigator.pop(context);
    Share.share(
      'Check out "${book.title}" by ${book.author} on Novook!\nhttps://novook.vercel.app/book/${book.id}',
      subject: book.title,
    );
  }

  void _showLoginRequired(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please sign in to use this feature'),
        action: SnackBarAction(
          label: 'Sign In',
          onPressed: () {},
        ),
      ),
    );
  }

  void _showAddToPlaylistDialog(BuildContext context, WidgetRef ref) {
    // TODO: Show dialog to select or create playlist
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add to playlist coming soon!')),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
