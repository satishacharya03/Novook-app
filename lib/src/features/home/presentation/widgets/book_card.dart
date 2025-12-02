import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/utils/color_utils.dart';
import '../../domain/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail
        AspectRatio(
          aspectRatio: 16 / 9,
          child: InkWell(
            onTap: () => context.push('/book/${book.id}', extra: book),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Background Blur
                  if (book.coverUrl != null || book.cover != null)
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: book.coverUrl ?? book.cover ?? '',
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
                    )
                  else
                    Positioned.fill(
                      child: Container(
                        color: _parseColor(book.coverColor) ?? const Color(0xFFD6BB87),
                        child: Stack(
                          children: [
                             // Texture overlay simulation (optional)
                             Positioned.fill(
                               child: Container(
                                 decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                     colors: [Colors.black.withOpacity(0.05), Colors.transparent, Colors.black.withOpacity(0.1)],
                                   ),
                                 ),
                               ),
                             ),
                             Center(
                               child: Padding(
                                 padding: const EdgeInsets.all(16.0),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(
                                       book.title,
                                       textAlign: TextAlign.center,
                                       maxLines: 2,
                                       overflow: TextOverflow.ellipsis,
                                       style: const TextStyle(
                                         fontFamily: 'Serif',
                                         fontWeight: FontWeight.bold,
                                         fontSize: 18,
                                         color: Color(0xFF0F172A), // Slate 900
                                       ),
                                     ),
                                     const SizedBox(height: 4),
                                     Text(
                                       book.author,
                                       textAlign: TextAlign.center,
                                       style: const TextStyle(
                                         fontSize: 14,
                                         fontWeight: FontWeight.w500,
                                         color: Color(0xFF334155), // Slate 700
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                          ],
                        ),
                      ),
                    ),

                  // Main Cover Image (if exists)
                  if (book.coverUrl != null || book.cover != null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CachedNetworkImage(
                          imageUrl: book.coverUrl ?? book.cover ?? '',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Metadata
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            InkWell(
              onTap: () {
                // Navigate to profile
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: getAvatarColor(book.uploader?.name ?? book.author),
                backgroundImage: book.uploader?.image != null ? CachedNetworkImageProvider(book.uploader!.image!) : null,
                child: book.uploader?.image == null
                    ? Text(
                        (book.uploader?.name ?? book.author).substring(0, 1).toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => context.push('/book/${book.id}', extra: book),
                    child: Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.uploader?.name ?? book.author,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${book.views} views • 2 days ago', // TODO: Implement relative time
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            // Menu
            IconButton(
              icon: const Icon(LucideIcons.moreVertical, size: 18),
              onPressed: () {
                // Show modal bottom sheet
              },
            ),
          ],
        ),
      ],
    );
  }

  Color? _parseColor(String? colorStr) {
    if (colorStr == null) return null;
    try {
      return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
    } catch (_) {
      return null;
    }
  }
}
