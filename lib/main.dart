import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novook/src/app.dart';
import 'package:pdfrx/pdfrx.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:novook/src/features/settings/data/settings_repository.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await pdfrxFlutterInitialize();
  } catch (e) {
    debugPrint('Error initializing pdfrx: $e');
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(AsyncData(sharedPreferences)),
      ],
      child: const MyApp(),
    ),
  );
}
