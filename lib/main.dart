import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:speedytool/pages/home_page.dart';
import 'package:speedytool/router/web_router.dart';

import 'package:flutter_web_plugins/url_strategy.dart';




void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBvcofHaUWewXSmFcE8X3oS60vDx0i4Dw8",
        projectId: "speedytool",
        messagingSenderId: "547696260866",
        appId: "1:547696260866:web:ea7415b184aa414c3ff41b",
    ),
  );

  usePathUrlStrategy(); //Remove # Routing

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Speedy Tool',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      // home: Scaffold(
      //   body: HomePage()
      // ),
    );
  }
}

