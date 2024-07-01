import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DirectOrderNotifier extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> placeDirectOrder(String userId, Map<String, dynamic> productDetails, Map<String, dynamic> paymentDetails, Map<String, dynamic> userDetails) async {

      Map<String, dynamic> orderDetails = {
        'userDetails': userDetails,
        'items': [productDetails],
        'totalPrice': productDetails['price'],
        'orderDate': FieldValue.serverTimestamp(),
        'paymentDetails': paymentDetails,
      };


      await _db.collection('users').doc(userId).collection('orders').add(orderDetails);



      await _db.collection('allOrders').add(orderDetails);


      notifyListeners();
    
  }
}
