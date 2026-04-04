import 'package:flutter/material.dart';
import 'package:speedytool/data/user_guide_data.dart';
import 'package:speedytool/widgets/custom_footer.dart';
import 'package:speedytool/widgets/user_guide_section.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

import 'package:image/image.dart' as img;
import 'dart:html' as html;
import 'dart:typed_data';

class ImageCompressorPage extends StatefulWidget {
  const ImageCompressorPage({super.key});

  @override
  State<ImageCompressorPage> createState() => _ImageCompressorPageState();
}

class _ImageCompressorPageState extends State<ImageCompressorPage> {
  html.File? file;
  Uint8List? originalBytes;
  Uint8List? compressedBytes;

  double targetSizeKB = 30;

  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 📌 Pick Image
  void pickImage() {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();

        reader.readAsArrayBuffer(files.first);

        reader.onLoadEnd.listen((event) {
          setState(() {
            file = files.first;
            originalBytes = reader.result as Uint8List;
            compressedBytes = null;

            double originalKB = originalBytes!.length / 1024;

            // 🔥 Fix target size range
            targetSizeKB = originalKB > 30 ? 30 : originalKB;
          });
          // 🔥 Auto compress after selecting image
          compressToTargetSize();
        });
      }
    });
  }

  // 📌 Compress to target size (Binary Search)
  Future<void> compressToTargetSize() async {
    if (originalBytes == null) return;

    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 10));

    try {
      final image = img.decodeImage(originalBytes!);
      if (image == null) throw Exception("Invalid image");

      int targetBytes = (targetSizeKB * 1024).toInt();

      int minQuality = 5;
      int maxQuality = 100;

      Uint8List? bestBytes;

      while (minQuality <= maxQuality) {
        int mid = (minQuality + maxQuality) ~/ 2;

        final compressed = img.encodeJpg(image, quality: mid);
        int size = compressed.length;

        if (size > targetBytes) {
          maxQuality = mid - 1;
        } else {
          bestBytes = Uint8List.fromList(compressed);
          minQuality = mid + 1;
        }
      }

      if (mounted) {
        setState(() {
          compressedBytes = bestBytes;
        });
      }
    } catch (e) {
      print("Compression error: $e");
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  // 📌 Download image
  void downloadImage() {
    if (compressedBytes == null) return;

    final blob = html.Blob([compressedBytes!]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "compressed.jpg")
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: Stack(
        children : [ SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomAppBar(scaffoldKey: _scaffoldKey),
        
              // 📌 Upload Box
              GestureDetector(
                onTap: pickImage,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Click to browse",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        
        
              // 📌 Original Image
              if (originalBytes != null)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Original Image",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
        
                    const SizedBox(height: 10),
                    Image.memory(originalBytes!, height: 150),
        
                    const SizedBox(height: 10),
                    Text(
                      "Size: ${originalBytes!.length ~/ 1024} KB",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
        
              // 📌 Target Size Slider
              if (originalBytes != null)
                Column(
                  children: [
                    const SizedBox(height: 10),
        
                    Text(
                      "Target Size: ${targetSizeKB.toInt()} KB",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
        
                    Slider(
                      value: targetSizeKB,
                      min: 10,
                      max: (originalBytes!.length / 1024) < 10
                          ? 10
                          : (originalBytes!.length / 1024),
                      divisions: 20,
                      onChanged: isLoading
                          ? null
                          : (value) async {
                        setState(() {
                          targetSizeKB = value;
                        });

                        await compressToTargetSize(); // 🔥 ensures one at a time
                      },
                    ),
        
                    Text(
                      "* Final size may vary slightly",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
        
              // 📌 Compressed Result
              if (compressedBytes != null && !isLoading)
                Column(
                  children: [
                    const SizedBox(height: 15),
        
                    Text(
                      "Compressed Image",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
        
                    const SizedBox(height: 10),
                    Image.memory(compressedBytes!, height: 150),
        
                    const SizedBox(height: 10),
        
                    Text(
                      "Original: ${originalBytes!.length ~/ 1024} KB",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
        
                    Text(
                      "Target: ${targetSizeKB.toInt()} KB",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
        
                    Text(
                      "Final: ${compressedBytes!.length ~/ 1024} KB",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        
                    const SizedBox(height: 10),
        
                    ElevatedButton(
                      onPressed: downloadImage,
                      child: const Text("Download"),
                    ),
                  ],
                ),
        
              const SizedBox(height: 15),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GuideSection(guide: guideData["image"]!),
              ),
        
              CustomFooter(),
            ],
          ),
        ),

          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 15),
                        Text(
                          "Compressing image...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    ]
    ),
    );
  }
}
