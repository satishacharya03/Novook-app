import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:novook/src/features/settings/presentation/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Account'),
          ListTile(
            leading: const Icon(LucideIcons.user),
            title: const Text('Manage your account'),
            onTap: () {
              // TODO: Navigate to account settings
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'General'),
          ListTile(
            leading: const Icon(LucideIcons.moon),
            title: const Text('Appearance'),
            subtitle: Text('Choose your light or dark theme preference'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? newValue) {
                if (newValue != null) {
                  ref.read(settingsControllerProvider.notifier).updateThemeMode(newValue);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Device'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark theme'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(LucideIcons.playCircle),
            title: const Text('Playback'),
            onTap: () {
              // TODO: Navigate to playback settings
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.download),
            title: const Text('Downloads'),
            onTap: () {
              // TODO: Navigate to downloads settings
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.bell),
            title: const Text('Notifications'),
            onTap: () {
              // TODO: Navigate to notifications settings
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.lock),
            title: const Text('Privacy'),
            onTap: () {
              // TODO: Navigate to privacy settings
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(LucideIcons.info),
            title: const Text('About Novook'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
