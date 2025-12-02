import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novook_mobile/src/app.dart';
import 'package:pdfrx/pdfrx.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await pdfrxFlutterInitialize();
  } catch (e) {
    debugPrint('Error initializing pdfrx: $e');
  }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
