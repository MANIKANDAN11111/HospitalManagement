import 'package:flutter/material.dart';
// ✅ Reusable resources
import 'package:simple/Reusable/color.dart';
class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDarkMode;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isDarkMode,
  });

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
    BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Awareness'),
    BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: isDarkMode ? Colors.amber : appPrimaryColor,
      unselectedItemColor: isDarkMode ? Colors.grey[600] : blackColor.withOpacity(0.5),
      backgroundColor: isDarkMode ? Colors.grey[800] : whiteColor,
      onTap: onTap,
      items: navItems,
    );
  }
}
