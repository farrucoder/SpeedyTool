import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speedytool/pages/blog_page.dart';
import '../data/info_pages_data.dart';
import '../pages/home_page.dart';
import '../pages/info_page.dart';
import 'drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            // 🔥 TOP MENU
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 40),

                  DrawerItem(
                    title: 'Home',
                    onTap: () {
                      if (GoRouterState.of(context).uri.toString() != '/') {
                        context.go('/');
                      }
                    },
                  ),

                  DrawerItem(
                    title: 'Blog',
                    onTap: () {
                      if (GoRouterState.of(context).uri.toString() != '/blog') {
                        context.go('/blog');
                      }
                    },
                  ),

                  DrawerItem(
                    title: 'About',
                    onTap: () {
                      if (GoRouterState.of(context).uri.toString() != '/about') {
                        context.go('/about');
                      }
                    },
                  ),
                ],
              ),
            ),

            // 🔥 DIVIDER
            Divider(color: Colors.white.withOpacity(0.1)),

            SizedBox(height: 10),

            // 🔥 ICONS (Professional touch)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _icon(Icons.public),
                _icon(Icons.email),
                _icon(Icons.link),
              ],
            ),

            SizedBox(height: 15),

            // 🔥 BRAND
            Text(
              "SpeedyTool",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 6),

            // 🔥 TAGLINE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Fast & free online tools for everyday needs.",
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white70, size: 18),
      ),
    );
  }
}
