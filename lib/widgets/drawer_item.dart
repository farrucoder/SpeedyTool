import 'package:flutter/material.dart';
import 'glass_container.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassContainer(
          child: Text(title, style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
