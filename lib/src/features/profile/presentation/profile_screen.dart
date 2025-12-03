import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../auth/presentation/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: isLoggedIn && currentUser != null
          ? _buildLoggedInProfile(context, ref, currentUser)
          : _buildLoggedOutProfile(context),
    );
  }

  Widget _buildLoggedInProfile(BuildContext context, WidgetRef ref, user) {
    return ListView(
      children: [
        // User Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: user.image != null
                    ? NetworkImage(user.image!)
                    : null,
                child: user.image == null
                    ? Text(
                        (user.name ?? 'U').substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 32),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? 'User',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '@${user.username ?? 'username'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Edit profile
                      },
                      icon: const Icon(LucideIcons.edit, size: 16),
                      label: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        // Menu Items
        _buildMenuItem(
          context,
          icon: LucideIcons.history,
          title: 'History',
          onTap: () {
            // Navigate to library with history tab
          },
        ),
        _buildMenuItem(
          context,
          icon: LucideIcons.bookmark,
          title: 'Saved Books',
          onTap: () {
            // Navigate to library with saved tab
          },
        ),
        _buildMenuItem(
          context,
          icon: LucideIcons.listVideo,
          title: 'Your Playlists',
          onTap: () {
            // Navigate to library with playlists tab
          },
        ),
        _buildMenuItem(
          context,
          icon: LucideIcons.download,
          title: 'Downloads',
          onTap: () => context.push('/downloads'),
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: LucideIcons.settings,
          title: 'Settings',
          onTap: () => context.push('/settings'),
        ),
        _buildMenuItem(
          context,
          icon: LucideIcons.helpCircle,
          title: 'Help & Feedback',
          onTap: () {},
        ),
        const Divider(),
        _buildMenuItem(
          context,
          icon: LucideIcons.logOut,
          title: 'Sign Out',
          isDestructive: true,
          onTap: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('Are you sure you want to sign out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            );
            if (confirmed == true) {
              await ref.read(authControllerProvider.notifier).logout();
            }
          },
        ),
      ],
    );
  }

  Widget _buildLoggedOutProfile(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                LucideIcons.user,
                size: 48,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Sign in to your account',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Access your library, bookmarks, and personalized recommendations',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => context.push('/login'),
              icon: const Icon(LucideIcons.logIn),
              label: const Text('Sign In'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.push('/register'),
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : null,
      ),
      title: Text(
        title,
        style: isDestructive ? const TextStyle(color: Colors.red) : null,
      ),
      trailing: const Icon(LucideIcons.chevronRight, size: 20),
      onTap: onTap,
    );
  }
}
