import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/faq_data.dart';
import '../data/user_guide_data.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_footer.dart';
import '../widgets/faq_item.dart';
import '../widgets/tool_card.dart';
import '../widgets/user_guide_section.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    int crossAxisCount = MediaQuery.of(context).size.width < 600 ? 2 : 3;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),

      body: Column(
        children: [
          SizedBox(height: 20),
          CustomAppBar(scaffoldKey: _scaffoldKey),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 🔥 HEADLINE
                        Center(
                          child: Text(
                            "All-in-One Speedy Tool",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        // 🔥 SLOGAN
                        Text(
                          "Generate QR codes, compress images, and use powerful tools instantly — fast, free, and high quality.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 20),

                        // 🔥 OPTIONAL TAGS (PRO LOOK)
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _tag("⚡ Fast"),
                            _tag("🎯 Free"),
                            _tag("🔒 Secure"),
                            _tag("📱 No Login"),
                          ],
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ToolCard(
                          title: "QR Generator",
                          icon: Icons.qr_code,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (_) => QRGeneratorPage()),
                            // );

                            context.go('/qr-generator');

                          },
                        ),
                        // ToolCard(
                        //   title: "Reel Downloader",
                        //   icon: Icons.qr_code,
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (_) => VideoDownloaderPage()),
                        //     );
                        //   },
                        // ),
                        ToolCard(
                          title: "Image Compressor",
                          icon: Icons.image,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (_) => ImageCompressorPage()),
                            // );

                            context.go('/image-compressor');
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),


                  GuideSection(
                    guide: guideData["qr"]!,
                  ),

                  GuideSection(
                    guide: guideData["image"]!,
                  ),

                  // GuideSection(
                  //   guide: guideData["video"]!,
                  // ),

                  SizedBox(height: 40),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "FAQs",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  ...faqList.map((faq) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: FAQItem(faq: faq),
                  )),

                  SizedBox(height: 40),

                  /// 📄 Footer
                  Center(child: CustomFooter()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey[300], fontSize: 16),
      ),
    );
  }
}
