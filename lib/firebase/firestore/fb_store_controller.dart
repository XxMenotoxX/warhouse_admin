import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/model/product_model.dart';
import 'package:admin_app_flutter/model/subcategories_model.dart';
import 'package:admin_app_flutter/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/timeformat.dart';

class FbStoreController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<bool> create(
      {required MainCategories mainCategories,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(mainCategories.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> createSubCategories(
      {required SubCategories subCategories,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .add(subCategories.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> createUser({
    required UserData userData,
    required String collectionName,
  }) async {
    return await _firebaseFirestore
        .collection("Admins")
        .doc(firebaseUser!.uid)
        .set({"ImageUrl": userData.ImageUrl, "name": userData.name})
        .then((value) => true)
        .catchError((error) => false);
  }

  // Future<String?> getUser({
  //   required String collectionName,
  // }) async {
  //   // var firebaseUser =  FirebaseAuth.instance.currentUser;
  //   return await _firebaseFirestore
  //       .collection(collectionName)
  //       .doc(firebaseUser!.uid)
  //       .get()
  //       .then((value) => UserData.fromMap(value.data()!));
  // }

  Future<bool> createProduct(
      {required Products products, required String collectionName}) async {
        //create unique id for product
        String id = DateTime.now().millisecond.toString();
        products.path = id;
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(id)
        .set(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> update(
      {required String path,
      required MainCategories mainCategories,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(mainCategories.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateSubCategories(
      {required String path,
      required SubCategories subCategories,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(subCategories.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateProducts(
      {required String path,
      required Products products,
      required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .update(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> delete(
      {required String path, required String collectionName}) async {
    return await _firebaseFirestore
        .collection(collectionName)
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> read({required String collectionName}) async* {
    yield* _firebaseFirestore.collection(collectionName).snapshots();
  }
  //
  // Future<QuerySnapshot> readDataUser({required String collectionName}) async* {
  //   yield* _firebaseFirestore.collection(collectionName).snapshots();
  // }

  Future<bool> createProductsLogs(
      {required List<Products> product, required String collectionName}) async {
    final now = DateTime.now();

    return await _firebaseFirestore
        .collection(collectionName)
        .add({
          'orderId':
              '${TimeDate.orderTimeDate(DateTime.now().microsecondsSinceEpoch)}',
          "product": product.map((e) => e.toMap()).toList(),
          "numberOfProducts": product.length,
          'userId': firebaseUser!.displayName ?? firebaseUser!.email,
        })
        .then((value) => true)
        .catchError((error) => false);
  }
  
  Future<bool> addProductOrder({
    required Products products,
  }) async {
    return await _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid)
        .collection('productId')
        .doc(products.path)
        .set(products.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
    Stream<QuerySnapshot> readUserProductCart() async* {
    yield* _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid)
        .collection('productId')
        .snapshots();
  }
    Future deleteAllProductsFromCart() async {
    //delete all products from cart
    return await _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid)
        .collection('productId')
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));
  }
  //change product count in cart

 Future changeProductCount({
    required Products products,
    required int productCount,
  }) async {
    return await _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid)
        .collection('productId')
        .doc(products.path)
        .update({'productCount': productCount})
        .then((value) => true)
        .catchError((error) => false);
  }
  Future<bool> deleteProducts({required String path}) async {
    return await _firebaseFirestore
        .collection('ItemCart')
        .doc(firebaseUser!.uid)
        .collection('productId')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}

