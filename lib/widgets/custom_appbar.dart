import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
              width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child:Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        child: Icon(Icons.menu, color: Colors.grey),
                      ),
                    )
                  ],
                ),
                Text(
                  "Speedy Tool",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}