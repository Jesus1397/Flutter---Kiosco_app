import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConnection {
  FirebaseFirestore fireConnection = FirebaseFirestore.instance;

  void getCategories() async {
    List categories = [];
    CollectionReference collectionReference =
        fireConnection.collection('categorias');

    QuerySnapshot catCollection = await collectionReference.get();

    if (catCollection.docs.length != 0) {
      for (var doc in catCollection.docs) {
        print(doc.data());
        categories.add(
          (doc.data()),
        );
      }
    }
  }

  void getProducts(String colecctionString) async {
    List products = [];
    CollectionReference collectionReference = fireConnection.collection(
      'categorias/$colecctionString/productos',
    );

    QuerySnapshot prodCollection = await collectionReference.get();

    if (prodCollection.docs.length != 0) {
      for (var doc in prodCollection.docs) {
        print(doc.data());
        products.add(doc.data());
      }
    }
  }
}
