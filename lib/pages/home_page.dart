import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiosco_app/providers/firebaseauth_provider.dart';
import 'package:kiosco_app/utils/color_palet.dart';
import 'package:kiosco_app/widgets/gridview_widget.dart';
import 'package:kiosco_app/widgets/hiddendrawermenu_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scaleFactor = 1.0;
  bool isDrawerOpen = false;
  FirebaseAuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    context.watch<User>();
    context.read<FirebaseAuthProvider>().signIn(
          email: 'test@gmail.com',
          password: '123456',
        );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            HiddenDrawerMenuWidget(),
            AnimatedContainer(
              transform: Matrix4.translationValues(
                xOffset,
                yOffset,
                0,
              )..scale(scaleFactor),
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: CustomColorDark.bgColor,
                borderRadius: isDrawerOpen
                    ? BorderRadius.circular(20)
                    : BorderRadius.circular(0),
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDrawerOpen
                            ? IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: CustomColorDark.detailsColor,
                                ),
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    xOffset = 0.0;
                                    yOffset = 0.0;
                                    scaleFactor = 1.0;
                                    isDrawerOpen = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Color(0xff3AC1C6),
                                ),
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    xOffset = size.width * 0.7;
                                    yOffset = size.height * 0.15;
                                    scaleFactor = 0.7;
                                    isDrawerOpen = true;
                                  });
                                },
                              ),
                        Icon(
                          Icons.store,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: CustomColorDark.detailsColor,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GridviewWidget(size: size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
