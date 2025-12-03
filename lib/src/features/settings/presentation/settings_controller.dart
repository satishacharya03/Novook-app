import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:novook/src/features/settings/data/settings_repository.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<void> build() {
    // No-op
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    final repository = ref.read(settingsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.setThemeMode(mode.name));
  }
}

@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  final modeName = repository.getThemeMode();
  return ThemeMode.values.firstWhere(
    (e) => e.name == modeName,
    orElse: () => ThemeMode.system,
  );
}
