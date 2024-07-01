import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartNotifier extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;




  Map<String, dynamic> _orderDetails = {};

  Map<String, dynamic> get orderDetails => _orderDetails;

  Future<void> addToCart(String userId, Map<String, dynamic> cartItemData) async {
    try {
      await _db.collection('users').doc(userId).collection('mycart').add(cartItemData);
      await fetchCartItems(userId);
    } catch (e) {
      print("Failed to add item to cart: $e");
    }
  }

  Future<void> fetchCartItems(String userId) async {
    try {
      QuerySnapshot snapshot = await _db.collection('users').doc(userId).collection('mycart').get();
      _cartItems = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Failed to fetch cart items: $e");
    }
  }

  Future<void> removeFromCart(String userId, String itemId) async {
    try {
      await _db.collection('users').doc(userId).collection('mycart').doc(itemId).delete();

      await fetchCartItems(userId);
    } catch (e) {
      print("Failed to remove item from cart: $e");
    }
  }

  Future<void> updateCartItem(String userId, String itemId, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection('users').doc(userId).collection('mycart').doc(itemId).update(updatedData);
      await fetchCartItems(userId);
    } catch (e) {
      print("Failed to update item: $e");
    }
  }

  Future<void> placeOrder(String userId, Map<String, dynamic> paymentDetails, Map<String, dynamic> userDetails) async {
    try {

      Map<String, dynamic> orderDetails = {
        'userDetails': userDetails,
        'items': _cartItems,
        'totalPrice': getTotalPrice(),
        'orderDate': FieldValue.serverTimestamp(),
        'paymentDetails': paymentDetails,
      };


      await _db.collection('users').doc(userId).collection('orders').add(orderDetails);



      await _db.collection('allOrders').add(orderDetails);


      await _clearCart(userId);
    } catch (e) {
      print("Failed to place order: $e");
    }
  }

  Future<void> _clearCart(String userId) async {
    try {
      QuerySnapshot snapshot = await _db.collection('users').doc(userId).collection('mycart').get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      _cartItems = [];
      notifyListeners();

    } catch (e) {
      print("Failed to clear cart: $e");
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      var price = item['price'];
      if (price is String) {
        price = double.tryParse(price) ?? 0.0;
      }
      total += (price ?? 0.0) as double;
    }
    return total;
  }


  Future<void> fetchOrderDetails(String userId) async {
    try {
      QuerySnapshot snapshot = await _db.collection('users').doc(userId).collection('orders').get();
      if (snapshot.docs.isNotEmpty) {
        _orderDetails = snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        _orderDetails = {};
      }
      notifyListeners();
    } catch (e) {
      print("Failed to fetch order details: $e");
    }
  }
}
