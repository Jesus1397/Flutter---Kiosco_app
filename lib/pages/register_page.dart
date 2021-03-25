import 'package:flutter/material.dart';
import 'package:kiosco_app/providers/firebaseauth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff00587a),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff0f3057),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height - kToolbarHeight,
            color: Color(0xff0f3057),
            padding: EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 60,
            ),
            child: Form(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Column(
                      children: [
                        TextField(
                          controller: emailController,
                          cursorColor: Color(0xff00587a),
                          decoration: InputDecoration(
                            labelText: "E - mail",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00587a),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00587a),
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: passwordController,
                          cursorColor: Color(0xff00587a),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00587a),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00587a),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        // SizedBox(height: 30),
                        // TextField(
                        //   controller: passwordController,
                        //   cursorColor: Color(0xff00587a),
                        //   decoration: InputDecoration(
                        //     labelText: "Repassword",
                        //     labelStyle: TextStyle(
                        //       color: Colors.white,
                        //     ),
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xff00587a),
                        //       ),
                        //     ),
                        //     focusedBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xff00587a),
                        //       ),
                        //     ),
                        //   ),
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<FirebaseAuthProvider>().signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff00587a),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ya tenes cuenta?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                ' Iniciar sesión',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, 'login');
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
