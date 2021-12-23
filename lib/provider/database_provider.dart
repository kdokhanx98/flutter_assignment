
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/wishlist.dart';

import '../constants.dart';

class DatabaseProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference wishlistRef =
      FirebaseFirestore.instance.collection(wishListCollectionName);

  final List<WishList> _wishList = [];

  List<WishList> get getWishList {
    return [..._wishList];
  }

  Future<bool> addWishlist(WishList wishList) async {
    bool isAdded = false;
    await wishlistRef.add({
      'name': wishList.name,
      'description': wishList.description,
      'price': wishList.price,
      'date_added': DateTime.now().millisecondsSinceEpoch,
    }).then((value) {
      wishlistRef.doc(value.id).update({'wishListId': value.id});
      isAdded = true;
    }).catchError((error) {
    });

    if (isAdded) {
      notifyListeners();
    }

    return isAdded;
  }

  Future<bool> removeWishList(String docId) async {
    bool isDeleted = false;
    await wishlistRef.doc(docId).delete().then((value) {
      isDeleted = true;
    }).catchError((error) {});

    return isDeleted;
  }

  Future<bool> editWishList(String docId, WishList wishList) async {
    bool isEdited = false;
    await wishlistRef.doc(docId).update({
      'name': wishList.name,
      'description': wishList.description,
      'price': wishList.price,
    }).then((value) {

      isEdited = true;
    }).catchError((error) {
    });
    return isEdited;
  }

  Future<void> getWishlistData() async {
    _wishList.clear();
    QuerySnapshot querySnapshot =
        await wishlistRef.orderBy('date_added', descending: true).get();
    querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      _wishList.add(WishList(data['name'], data['description'], data['price'],
          wishListId: data['wishListId']));
    }).toList();

    notifyListeners();
  }
}
