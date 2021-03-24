import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kiosco_app/models/args_model.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArgModel args = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF00587a),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          color: Color(0xFF0f3057),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      args.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height - kToolbarHeight - 54,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('categorias/${args.colName}/productos')
                      .snapshots(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          QueryDocumentSnapshot product =
                              snapshot.data.docs[index];

                          if (snapshot.data.docs.length == 0) {
                            return Center(
                              child: Text('No hay productos UwU'),
                            );
                          } else {
                            return GestureDetector(
                              child: ProductItem(product: product),
                              onTap: () {
                                _settingModalBottomSheet(context, product);
                              },
                            );
                          }
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xff008891),
        onPressed: () {
          Navigator.pushNamed(context, 'addProduct');
        },
      ),
    );
  }
}

void _settingModalBottomSheet(
    BuildContext context, QueryDocumentSnapshot product) {
  Size size = MediaQuery.of(context).size;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
            height: size.height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Container(
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff008891),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: [
                                Text(
                                  'Precio',
                                  style: TextStyle(),
                                ),
                                Text(
                                  product.get('precio').toString(),
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: [
                                Text(
                                  'Cantidad',
                                  style: TextStyle(),
                                ),
                                Text(
                                  product.get('stock').toString(),
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: [
                                Text(
                                  'Vencimiento',
                                  style: TextStyle(),
                                ),
                                Text(
                                  product.get('vencimiento').toString(),
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: [
                                Text(
                                  'Sabor',
                                  style: TextStyle(),
                                ),
                                Text(
                                  product.get('sabor').toString(),
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.shop,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.get('nombre'),
                      style: TextStyle(),
                    ),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ));
      });
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final QueryDocumentSnapshot product;

  Future<String> getImage(BuildContext context, String imageName) async {
    String image;
    await FirebaseStorage.instance
        .ref()
        .child(imageName)
        .getDownloadURL()
        .then((value) {
      image = value;
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // FutureBuilder(
          //   future: getImage(context, 'productos/coca-cola.png'),
          //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return Container(
          //         width: 50,
          //         height: 50,
          //         child: Image.network(snapshot.data),
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),

          Column(
            children: [
              Text(
                product.get('nombre'),
              ),
              Text(
                '\$${product.get('precio')}',
                style: TextStyle(),
              )
            ],
          ),
          Icon(Icons.arrow_right_sharp)
        ],
      ),
    );
  }
}
