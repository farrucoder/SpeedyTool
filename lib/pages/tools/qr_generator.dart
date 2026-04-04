import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:speedytool/data/user_guide_data.dart';
import 'package:speedytool/widgets/custom_footer.dart';
import 'package:speedytool/widgets/user_guide_section.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class QRGeneratorPage extends StatefulWidget {
  @override
  _QRGeneratorPageState createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  String data = "";
  final TextEditingController controller = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey qrKey = GlobalKey();

  void downloadQR() async {
    try {
      final boundary =
      qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3);
      final byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

      final pngBytes = byteData!.buffer.asUint8List();

      final blob = html.Blob([pngBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute("download", "qr_code.png")
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print("Download error: $e");
    }
  }

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
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 15),
                  // 🔥 INPUT FIELD
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter text or URL...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                        onChanged: (value) {
                          setState(() => data = value);
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // 🔥 QR RESULT
                  if (data.isNotEmpty)
                    Column(
                      children: [

                        Text(
                          "Generated QR Code",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        // QR BOX
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: RepaintBoundary(
                            key: qrKey,
                            child: QrImageView(
                              data: data,
                              size: 200,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // 🔥 DOWNLOAD BUTTON
                        ElevatedButton(
                          onPressed: downloadQR,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Download QR"),
                        ),
                      ],
                    ),


                  GuideSection(guide: guideData["qr"]!,),

                  SizedBox(height: 15),

                  CustomFooter(),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}