import 'package:flutter/material.dart';
import '../models/user_guide_model.dart';

class GuideSection extends StatelessWidget {
  final GuideModel guide;

  const GuideSection({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 30),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Title
            Text(
              guide.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10),

            /// Description
            Text(
              guide.description,
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 20),

            /// Steps
            ...guide.steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Step Number Circle
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),

                    SizedBox(width: 10),

                    /// Step Text
                    Expanded(
                      child: Text(
                        step,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 15),

            /// Footer SEO Text
            Text(
              "This tool is completely free and works directly in your browser. No installation required.",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}