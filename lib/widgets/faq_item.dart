import 'package:flutter/material.dart';
import '../models/faq_model.dart';

class FAQItem extends StatefulWidget {
  final FAQModel faq;

  const FAQItem({super.key, required this.faq});

  @override
  _FAQItemState createState() {
    return _FAQItemState();
  }
}

class _FAQItemState extends State<FAQItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.faq.question,
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              isOpen ? Icons.remove : Icons.add,
              color: Colors.grey,
            ),
            onTap: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
          ),

          if (isOpen)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                widget.faq.answer,
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}