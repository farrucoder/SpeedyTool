import 'package:flutter/material.dart';
import 'package:speedytool/widgets/custom_footer.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';

class InfoPage extends StatelessWidget {
  final String title;
  final String content;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   InfoPage({
     super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Column(
        children: [

          SizedBox(height: 20),
          CustomAppBar(scaffoldKey: _scaffoldKey),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // 🔥 CONTENT
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              content,
                              style: TextStyle(
                                color: Colors.grey[300],
                                height: 1.6,
                              ),
                            ),
                          ),

                          Spacer(), // 🔥 pushes footer to bottom

                          // 🔥 FOOTER
                          CustomFooter(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}