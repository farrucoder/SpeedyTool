import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/info_pages_data.dart';
import '../pages/info_page.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Brand Name
          Text(
            "SpeedyTool",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          // Short Description
          Text(
            "Fast & free online tools for everyday needs.",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20),

          // Links Row
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              _footerLink(context,"Privacy Policy"),
              _footerLink(context,"Terms & Conditions"),
              _footerLink(context,"Disclaimer"),
              _footerLink(context,"Contact"),
              _footerLink(context,"About"),
            ],
          ),

          SizedBox(height: 20),

          //  Copyright
          Text(
            "© 2026 SpeedyTools. All rights reserved.",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Widget page;

        switch (title) {
          case "Privacy Policy":
            page = InfoPage(title: title, content: privacyPolicy);
            break;
          case "Terms & Conditions":
            page = InfoPage(title: title, content: termsConditions);
            break;
          case "Disclaimer":
            page = InfoPage(title: title, content: disclaimer);
            break;
          case "Contact":
            page = InfoPage(title: title, content: contact);
            break;
          case "About":
            page = InfoPage(title: title, content: about);
            break;
          default:
            return;
        }

        // if (GoRouterState.of(context).uri.toString() != '/$page') {
        //   context.go('/$page');
        // }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

}