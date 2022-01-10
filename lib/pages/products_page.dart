import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiosco_app/models/args_model.dart';
import 'package:kiosco_app/utils/color_palet.dart';
import 'package:kiosco_app/utils/functions.dart';
import 'package:kiosco_app/widgets/productappbar_widget.dart';
import 'package:kiosco_app/widgets/productitem_widget.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArgModel args = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          color: CustomColorDark.bgColor,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProductAppbarWidget(args: args),
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
                      if (snapshot.data.docs.length != 0) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            QueryDocumentSnapshot product =
                                snapshot.data.docs[index];
                            return GestureDetector(
                              child: ProductItemWidget(product: product),
                              onTap: () {
                                modalBottomSheet(
                                  context,
                                  product,
                                  args.colName,
                                );
                              },
                              onLongPress: () {
                                showMyDialog(
                                  context,
                                  args.colName,
                                  product.id,
                                );
                              },
                            );
                          },
                        );
                      }
                      return Center(
                        child: Text(
                          'No hay productos',
                          style: TextStyle(),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: CustomColorDark.detailsColor,
        onPressed: () {
          Navigator.pushNamed(
            context,
            'addProduct',
            arguments: NameArgs(name: args.colName),
          );
        },
      ),
    );
  }
}

Future<void> showMyDialog(
    BuildContext context, String nombre, String id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Desea eliminar este producto?'),
        content: SingleChildScrollView(
          child: Text('El producto se eliminara de manerapermanente.'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('categorias/$nombre/productos')
                  .doc(id)
                  .delete();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
