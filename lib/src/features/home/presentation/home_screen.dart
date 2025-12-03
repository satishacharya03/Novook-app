import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/book_repository.dart';
import 'widgets/book_card.dart';
import 'widgets/category_chips.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text(
              'Booktube',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
            ),
            actions: [
              IconButton(
                icon: const Icon(LucideIcons.search),
                onPressed: () => GoRouter.of(context).push('/search'),
              ),
              IconButton(icon: const Icon(LucideIcons.bell), onPressed: () {}),
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(radius: 14, child: Text('U')),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: CategoryChips(),
            ),
          ),
          booksAsync.when(
            data: (books) => SliverPadding(
              padding: const EdgeInsets.only(bottom: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: BookCard(book: books[index]),
                    );
                  },
                  childCount: books.length,
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.alertCircle, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $error'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => ref.refresh(booksProvider),
                      child: const Text('Retry'),
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
