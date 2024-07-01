import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductProviderModel extends ChangeNotifier {
  String? _productid;
  String? _imageurl;
  String? _modelname;
  String? _companyname;
  String? _price;
  String? _ram;
  String? _storage;
  String? _description;

  String? get productid => _productid;
  String? get imageurl => _imageurl;
  String? get modelname => _modelname;
  String? get companyname => _companyname;
  String? get price => _price;
  String? get ram => _ram;
  String? get storage => _storage;
  String? get description => _description;

  Future<void> uploadProduct(
    File image,
    String modelname,
    String companyname,
    String price,
    String ram,
    String storage,
    String description,
  ) async {
    try {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child("images/$fileName");
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot storageTaskSnapshot = await uploadTask;

      if (storageTaskSnapshot.state == TaskState.success) {
        _imageurl = await storageReference.getDownloadURL();

        DocumentReference documentReference =
            await FirebaseFirestore.instance.collection('products').add({
          'url': _imageurl,
          'modelname': modelname,
          'companyname': companyname,
          'price': price,
          'ram': ram,
          'storage': storage,
          'description': description,
        });

        _productid = documentReference.id;

        await documentReference.update({
          'productid': _productid,
        });

        _modelname = modelname;
        _companyname = companyname;
        _price = price;
        _ram = ram;
        _storage = storage;
        _description = description;

        notifyListeners();
      } else {
        throw Exception("Failed to upload image");
      }
    } catch (e) {
      print("Error uploading product: $e");
      throw Exception("Failed to upload product");
    }
  }


}




class ProductViewProvider with ChangeNotifier {
  List<Map<String, dynamic>> _products = [];

  List<Map<String, dynamic>> get products => _products;

  Future<void> fetchProducts() async {
    try {

      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();


      if (snapshot.docs.isNotEmpty) {

        _products = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        notifyListeners();
      } else {

        print("No documents found in the collection");
      }
    } catch (e) {

      print("Error: $e");
    }
  }
}

