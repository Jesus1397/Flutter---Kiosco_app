import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosco_app/pages/addproduct_page.dart';
import 'package:kiosco_app/pages/home_page.dart';
import 'package:kiosco_app/pages/products_page.dart';

import 'package:kiosco_app/providers/theme_provider.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  return runApp(
    ChangeNotifierProvider<ThemeChangeProvider>(
      create: (_) => ThemeChangeProvider(
        ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color(0xff142850),
        ),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'products': (_) => ProductsPage(),
        'addProduct': (_) => AddProductPage(),
      },
    );
  }
}
