import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosco_app/providers/firebaseauth_provider.dart';
import 'package:kiosco_app/pages/addproduct_page.dart';
import 'package:kiosco_app/pages/home_page.dart';
import 'package:kiosco_app/pages/login_page.dart';
import 'package:kiosco_app/pages/products_page.dart';
import 'package:kiosco_app/pages/register_page.dart';

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChangeProvider>(
          create: (_) => ThemeChangeProvider(
            ThemeData.light().copyWith(
              scaffoldBackgroundColor: Color(0xff142850),
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
      initialRoute: 'auth',
      routes: {
        'home': (_) => HomePage(),
        'products': (_) => ProductsPage(),
        'addProduct': (_) => AddProductPage(),
        'login': (_) => LogInPage(),
        'register': (_) => RegisterPage(),
        'auth': (_) => AuthWrapper(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }

    return LogInPage();
  }
}
