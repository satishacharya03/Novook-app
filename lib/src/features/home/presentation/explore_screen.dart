import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/book_repository.dart';
import '../domain/book.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text(
              'Explore',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.search),
                onPressed: () => context.push('/search'),
              ),
              IconButton(
                icon: const Icon(LucideIcons.bell),
                onPressed: () {},
              ),
            ],
          ),
          // Categories Section
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _CategoryCard(
                    icon: LucideIcons.trendingUp,
                    label: 'Trending',
                    color: Colors.red,
                    onTap: () => context.push('/trending'),
                  ),
                  _CategoryCard(
                    icon: LucideIcons.music,
                    label: 'Music',
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  _CategoryCard(
                    icon: LucideIcons.gamepad2,
                    label: 'Fantasy',
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  _CategoryCard(
                    icon: LucideIcons.newspaper,
                    label: 'News',
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  _CategoryCard(
                    icon: LucideIcons.film,
                    label: 'Drama',
                    color: Colors.green,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          // Trending Section
          _TrendingSection(onSeeAll: () => context.push('/trending')),
          // Recommended Section  
          _RecommendedSection(onSeeAll: () {}),
          // Recently Added
          _RecentSection(onSeeAll: () {}),
          const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
        ],
      ),
    );
  }
}

class _TrendingSection extends ConsumerWidget {
  final VoidCallback onSeeAll;
  const _TrendingSection({required this.onSeeAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(trendingBooksProvider);
    return _BookSection(
      title: '🔥 Trending Now',
      booksAsync: booksAsync,
      onSeeAll: onSeeAll,
    );
  }
}

class _RecommendedSection extends ConsumerWidget {
  final VoidCallback onSeeAll;
  const _RecommendedSection({required this.onSeeAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(recommendedBooksProvider);
    return _BookSection(
      title: '✨ Recommended for You',
      booksAsync: booksAsync,
      onSeeAll: onSeeAll,
    );
  }
}

class _RecentSection extends ConsumerWidget {
  final VoidCallback onSeeAll;
  const _RecentSection({required this.onSeeAll});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);
    return _BookSection(
      title: '🆕 Recently Added',
      booksAsync: booksAsync,
      onSeeAll: onSeeAll,
    );
  }
}

class _BookSection extends StatelessWidget {
  final String title;
  final AsyncValue<List<Book>> booksAsync;
  final VoidCallback onSeeAll;

  const _BookSection({
    required this.title,
    required this.booksAsync,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: onSeeAll,
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: booksAsync.when(
              data: (books) => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: books.length > 10 ? 10 : books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    child: _CompactBookCard(book: book),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => const Center(
                child: Text('Failed to load', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withAlpha(75)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactBookCard extends StatelessWidget {
  final Book book;

  const _CompactBookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/book/${book.id}', extra: book),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              clipBehavior: Clip.antiAlias,
              child: book.coverUrl != null || book.cover != null
                  ? Image.network(
                      book.coverUrl ?? book.cover ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                    )
                  : _buildPlaceholder(context),
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 4),
          // Author & Views
          Text(
            '${book.author} • ${book.views} views',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Text(
          book.title.isNotEmpty ? book.title.substring(0, 1).toUpperCase() : 'B',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }
}
