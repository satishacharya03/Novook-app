import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novook_mobile/src/core/theme/theme.dart';
import 'package:novook_mobile/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'novook',
      theme: ThemeData.light(), // Fallback or implement light theme later
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Force dark mode for now as per design
    );
  }
}
