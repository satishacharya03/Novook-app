import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search books...',
            border: InputBorder.none,
          ),
          autofocus: true,
          textInputAction: TextInputAction.search,
          onSubmitted: (query) {
            // TODO: Perform search
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.mic),
            onPressed: () {
              // TODO: Voice search
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LucideIcons.search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Search for books, authors, or genres'),
          ],
        ),
      ),
    );
  }
}
