import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecProductViewProvider with ChangeNotifier {
  List<Map<String, dynamic>> _products = [];
  Map<String, dynamic>? _product;
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get products => _products;
  Map<String, dynamic>? get product => _product;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _setLoadingState(true);
    _setErrorMessage(null);
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();

      if (snapshot.docs.isNotEmpty) {
        _products = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      } else {
        _products = [];
        print("No documents found in the collection");
      }
    } catch (e) {
      _setErrorMessage("Error: $e");
    } finally {
      _setLoadingState(false);
    }
    notifyListeners();
  }

  Future<void> fetchProductById(String productId) async {
    _setLoadingState(true);
    _setErrorMessage(null);
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('products').doc(productId).get();

      if (doc.exists) {
        _product = doc.data() as Map<String, dynamic>?;
      } else {
        _product = null;
        print("No product found with the given ID");
      }
    } catch (e) {
      _setErrorMessage("Error: $e");
    } finally {
      _setLoadingState(false);
    }
    notifyListeners();
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
