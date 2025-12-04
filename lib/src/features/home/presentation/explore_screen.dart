import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/theme.dart';
import '../data/book_repository.dart';
import '../domain/book.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with gradient
          SliverAppBar(
            floating: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryAccent.withAlpha(30),
                      AppColors.background,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              title: Text(
                'Explore',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(LucideIcons.search, size: 20),
                ),
                onPressed: () => context.push('/search'),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(LucideIcons.bell, size: 20),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
            ],
          ),
          
          // Categories Section - Modern chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _CategoryChip(
                    icon: LucideIcons.trendingUp,
                    label: 'Trending',
                    gradient: const [Color(0xFFEF4444), Color(0xFFF97316)],
                    onTap: () => context.push('/trending'),
                  ),
                  _CategoryChip(
                    icon: LucideIcons.sparkles,
                    label: 'Fantasy',
                    gradient: const [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                    onTap: () {},
                  ),
                  _CategoryChip(
                    icon: LucideIcons.heart,
                    label: 'Romance',
                    gradient: const [Color(0xFFEC4899), Color(0xFFF472B6)],
                    onTap: () {},
                  ),
                  _CategoryChip(
                    icon: LucideIcons.swords,
                    label: 'Action',
                    gradient: const [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                    onTap: () {},
                  ),
                  _CategoryChip(
                    icon: LucideIcons.ghost,
                    label: 'Horror',
                    gradient: const [Color(0xFF1F2937), Color(0xFF374151)],
                    onTap: () {},
                  ),
                  _CategoryChip(
                    icon: LucideIcons.bookOpen,
                    label: 'Education',
                    gradient: const [Color(0xFF10B981), Color(0xFF34D399)],
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
          
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withAlpha(60),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
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
      title: 'Trending Now',
      emoji: '🔥',
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
      title: 'Recommended',
      emoji: '✨',
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
      title: 'Recently Added',
      emoji: '🆕',
      booksAsync: booksAsync,
      onSeeAll: onSeeAll,
    );
  }
}

class _BookSection extends StatelessWidget {
  final String title;
  final String emoji;
  final AsyncValue<List<Book>> booksAsync;
  final VoidCallback onSeeAll;

  const _BookSection({
    required this.title,
    required this.emoji,
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
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(emoji, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: onSeeAll,
                  icon: const Icon(LucideIcons.arrowRight, size: 16),
                  label: const Text('See All'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            child: booksAsync.when(
              data: (books) => books.isEmpty
                  ? Center(
                      child: Text(
                        'No books available',
                        style: TextStyle(color: AppColors.textTertiary),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: books.length > 10 ? 10 : books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: _ModernBookCard(book: book),
                        );
                      },
                    ),
              loading: () => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: _BookCardSkeleton(),
                ),
              ),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.alertCircle, color: AppColors.error, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Failed to load',
                      style: TextStyle(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernBookCard extends StatelessWidget {
  final Book book;

  const _ModernBookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/book/${book.id}', extra: book),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover with shadow
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: book.coverUrl != null || book.cover != null
                    ? Image.network(
                        book.coverUrl ?? book.cover ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                      )
                    : _buildPlaceholder(context),
              ),
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            // Author & Views
            Row(
              children: [
                Expanded(
                  child: Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(LucideIcons.eye, size: 12, color: AppColors.textTertiary),
                const SizedBox(width: 2),
                Text(
                  _formatViews(book.views),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryAccent.withAlpha(80),
            AppColors.secondaryAccent.withAlpha(80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          book.title.isNotEmpty ? book.title.substring(0, 1).toUpperCase() : 'B',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }
}

class _BookCardSkeleton extends StatelessWidget {
  const _BookCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 14,
            width: 120,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 12,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
