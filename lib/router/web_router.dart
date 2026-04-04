import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/blog_page.dart';
import '../pages/info_page.dart';
import '../data/info_pages_data.dart';
import '../pages/tools/image_compressor.dart';
import '../pages/tools/qr_generator.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    // 🔥 HOME
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),

    GoRoute(
      path: '/qr-generator',
      builder: (context, state) => QRGeneratorPage(),
    ),

    GoRoute(
      path: '/image-compressor',
      builder: (context, state) => ImageCompressorPage(),
    ),

    // 🔥 BLOG
    GoRoute(
      path: '/blog',
      builder: (context, state) => BlogPage(),
    ),

    // 🔥 ABOUT
    GoRoute(
      path: '/about',
      builder: (context, state) =>
          InfoPage(title: "About", content: about),
    ),

    // 🔥 CONTACT
    GoRoute(
      path: '/contact',
      builder: (context, state) =>
          InfoPage(title: "Contact", content: contact),
    ),

    // 🔥 PRIVACY
    GoRoute(
      path: '/privacy',
      builder: (context, state) =>
          InfoPage(title: "Privacy Policy", content: privacyPolicy),
    ),

    // 🔥 TERMS
    GoRoute(
      path: '/terms',
      builder: (context, state) =>
          InfoPage(title: "Terms & Conditions", content: termsConditions),
    ),
  ],
);