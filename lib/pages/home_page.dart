import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosco_app/models/args_model.dart';
import 'package:kiosco_app/providers/firebaseauth_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF00587a),
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
                color: Color(0xFF0f3057),
                borderRadius: isDrawerOpen
                    ? BorderRadius.circular(20)
                    : BorderRadius.circular(0),
              ),
              child: Column(
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
                                  color: Colors.white,
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
                                  color: Colors.white,
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
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height - kToolbarHeight - 24,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categorias')
                          .snapshots(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext ctx, index) {
                              QueryDocumentSnapshot doc =
                                  snapshot.data?.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    'products',
                                    arguments: ArgModel(
                                      id: doc.id,
                                      name: doc.get('name'),
                                      colName: doc.get('colName'),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    doc.get('name'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff27496d),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HiddenDrawerMenuWidget extends StatelessWidget {
  const HiddenDrawerMenuWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: FaIcon(FontAwesomeIcons.solidUser),
                backgroundColor: Color(0xFF0f3057),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jesus Avendaño',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Administrador',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.white.withOpacity(0.6),
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'Ajustes',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 16,
                width: 2,
                color: Colors.white.withOpacity(0.6),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<FirebaseAuthProvider>().signOut();
                },
                child: Text(
                  'Cerrar Sesion',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
