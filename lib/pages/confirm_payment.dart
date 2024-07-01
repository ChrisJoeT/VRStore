import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vrstore/provider/cartprovider.dart';

class Payment extends StatefulWidget {
  final double totalPrice;
  final String uid;

  const Payment({required this.uid, required this.totalPrice, Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late Razorpay _razorpay;
  Map<String, dynamic> _userDetails = {};

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    final userDetails = {
      'userName': _userDetails['name'] ?? 'Unknown',
      'phoneNumber': _userDetails['phoneNumber'] ?? 'Unknown',
      'address': _userDetails['address'] ?? 'Unknown',
    };
    final paymentDetails = {
      'orderId': response.orderId,
      'paymentId': response.paymentId,
      'signature': response.signature,
    };

    cartNotifier.placeOrder(widget.uid, paymentDetails, userDetails).then((_) {
      _showOrderConfirmationDialog();
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed: ${response.message}")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("External wallet selected: ${response.walletName}")));
  }

  void openCheckout(double totalPrice) {
    double amount = totalPrice * 100;

    var options = {
      'key': 'rzp_test_GcZZFDPP0jHtC4',
      'amount': amount,
      'name': 'GetPhone',
      'description': 'SmartPhone e-commerce',
      'prefill': {
        'contact': '7907194563',
        'email': 'getphone@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } on FirebaseAuthException catch(e){

                  List err=e.toString().split("]");

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  Future<void> fetchUserDetails(String uid) async {

      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          _userDetails = doc.data() as Map<String, dynamic>;
        });
      }

  }

  void _handleCODPayment() {
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    final userDetails = {
      'userName': _userDetails['name'] ?? 'Unknown',
      'phoneNumber': _userDetails['phoneNumber'] ?? 'Unknown',
      'address': _userDetails['address'] ?? 'Unknown',
    };
    final paymentDetails = {
      'paymentMethod': 'Cash on Delivery',
    };

    cartNotifier.placeOrder(widget.uid, paymentDetails, userDetails).then((_) {
      _showOrderConfirmationDialog();
    });
    
  }

  void _showOrderConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Confirmed'),
          content: const Text('Your order has been placed successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = Provider.of<CartNotifier>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserDetails(widget.uid);
      cartNotifier.fetchCartItems(widget.uid);
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'User Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Name: ${_userDetails['name'] ?? 'Unknown'}',style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Phone Number: ${_userDetails['phoneNumber'] ?? 'Unknown'}',style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Address: ${_userDetails['address'] ?? 'Unknown'}',style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily)),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cart Items:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cartNotifier.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartNotifier.cartItems[index];
                return ListTile(
                  title: Text(item['modelname'] ?? 'Unknown',style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily)),
                  subtitle: Text('Price: ${item['price'] ?? 'Unknown'}',style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily)),
                );
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Price: ${widget.totalPrice}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      openCheckout(widget.totalPrice);
                    },
                    child: const Text('Pay with Razorpay'),
                  ),
                  ElevatedButton(
                    onPressed: _handleCODPayment,
                    child: const Text('Cash on Delivery'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
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
