import '../models/user_guide_model.dart';

final Map<String, GuideModel> guideData = {

  "qr": GuideModel(
    title: "How to Use QR Code Generator",
    steps: [
      "Enter text, URL, or any data",
      "QR code will generate instantly",
      "Preview the QR code",
      "Click download to save as image",
    ],
    description:
    "Generate QR codes instantly for links, text, and more. No registration required.",
  ),

  "image": GuideModel(
    title: "How to Use Image Compressor",
    steps: [
      "Upload your image file",
      "Wait for compression process",
      "Preview compressed image",
      "Download optimized image",
    ],
    description:
    "Compress images online without losing quality. Fast, secure, and free.",
  ),

  "video": GuideModel(
    title: "How to Download Videos",
    steps: [
      "Paste the video link",
      "Click on download button",
      "Select video quality",
      "Save video to your device",
    ],
    description:
    "Download videos from popular platforms easily. No login required.",
  ),
};