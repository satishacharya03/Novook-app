import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/theme.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.surfaceContainerHighest.withAlpha(50),
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onTap(context, index),
          destinations: [
            _buildDestination(
              icon: LucideIcons.home,
              label: 'Home',
              isSelected: navigationShell.currentIndex == 0,
            ),
            _buildDestination(
              icon: LucideIcons.compass,
              label: 'Explore',
              isSelected: navigationShell.currentIndex == 1,
            ),
            _buildDestination(
              icon: LucideIcons.library,
              label: 'Library',
              isSelected: navigationShell.currentIndex == 2,
            ),
            _buildDestination(
              icon: LucideIcons.user,
              label: 'You',
              isSelected: navigationShell.currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildDestination({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return NavigationDestination(
      icon: Icon(icon, size: 22),
      selectedIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primaryAccent.withAlpha(30),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 22, color: AppColors.primaryAccent),
      ),
      label: label,
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
