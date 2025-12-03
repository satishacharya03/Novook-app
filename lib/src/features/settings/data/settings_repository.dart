import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).requireValue;
  return SettingsRepository(sharedPreferences);
}

class SettingsRepository {
  SettingsRepository(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const _themeModeKey = 'themeMode';

  Future<void> setThemeMode(String themeMode) async {
    await sharedPreferences.setString(_themeModeKey, themeMode);
  }

  String? getThemeMode() {
    return sharedPreferences.getString(_themeModeKey);
  }
}
