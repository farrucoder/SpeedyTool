import 'package:flutter/material.dart';
import 'glass_container.dart';

class ToolCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ToolCard({super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
          constraints: BoxConstraints(
            minHeight: 150, // 🔥 gives space for 2–3 lines
          ),
        child: GlassContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60,color: Colors.white,),
              SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}