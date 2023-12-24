import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/splash.dart';
import 'package:shopify/providers/app_auth_provider.dart';
import 'package:shopify/providers/category_provider.dart';
import 'package:shopify/providers/home_provider.dart';
import 'package:shopify/providers/product_provider.dart';
import 'package:shopify/utils/constants/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
        Provider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        Provider(create: (_) => CategoryProvider()),



      ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeConstants.themeData,
      home: const Splash(),
    );
  }
}

