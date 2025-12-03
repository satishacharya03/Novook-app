import 'package:flutter/material.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
      ),
      body: const Center(
        child: Text('Trending Books will appear here'),
      ),
    );
  }
}
