import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosco_app/pages/editproduct_page.dart';
import 'package:kiosco_app/providers/firebaseauth_provider.dart';
import 'package:kiosco_app/pages/addproduct_page.dart';
import 'package:kiosco_app/pages/home_page.dart';
import 'package:kiosco_app/pages/products_page.dart';

import 'package:kiosco_app/providers/theme_provider.dart';
import 'package:kiosco_app/utils/color_palet.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: CustomColorDark.bgColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChangeProvider>(
          create: (_) => ThemeChangeProvider(
            ThemeData.dark().copyWith(
              brightness: Brightness.dark,
              primaryColor: Colors.lightBlue[800],
              accentColor: Colors.cyan[600],
            ),
          ),
        ),
        Provider<FirebaseAuthProvider>(
          create: (_) => FirebaseAuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<FirebaseAuthProvider>().authStateChanges,
        ),
      ],
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
        'editProduct': (_) => EditProductPage(),
      },
    );
  }
}
