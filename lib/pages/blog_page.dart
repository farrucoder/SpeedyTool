import 'package:flutter/material.dart';
import '../data/blog_data.dart';
import '../models/blog_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';

class BlogPage extends StatelessWidget {
  BlogPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20),
            CustomAppBar(scaffoldKey: _scaffoldKey),

            // 🔥 TITLE
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Blogs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            // 🔥 BLOG LIST
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: blogList.length,
                itemBuilder: (context, index) {
                  final blog = blogList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlogDetailPage(blog: blog),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // 🔥 TITLE
                          Text(
                            blog.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          // 🔥 DESCRIPTION
                          Text(
                            blog.description,
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),

                          SizedBox(height: 10),

                          // 🔥 DATE
                          Text(
                            blog.date,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BlogDetailPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              blog.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              blog.date,
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 20),

            Text(
              blog.content,
              style: TextStyle(
                color: Colors.grey[300],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}