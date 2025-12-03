import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          const UserHeader(),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.history),
            title: const Text('History'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(LucideIcons.playSquare),
            title: const Text('Your Videos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(LucideIcons.download),
            title: const Text('Downloads'),
            onTap: () => context.push('/downloads'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.settings),
            title: const Text('Settings'),
            onTap: () => context.push('/settings'),
          ),
          ListTile(
            leading: const Icon(LucideIcons.helpCircle),
            title: const Text('Help & Feedback'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            child: Icon(LucideIcons.user, size: 32),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Name',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '@username',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
