import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vrstore/provider/directorder.dart';


class DirectOrderPage extends StatefulWidget {
  final  uid;
  final Map<String, dynamic> productDetails;

  const DirectOrderPage({required this.uid, required this.productDetails, Key? key}) : super(key: key);

  @override
  State<DirectOrderPage> createState() => _DirectOrderPageState();
}

class _DirectOrderPageState extends State<DirectOrderPage> {
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
    final directOrderNotifier = Provider.of<DirectOrderNotifier>(context, listen: false);
    final userDetails = {
      'userName': _userDetails['name'] ?? 'Unknown',
      'phoneNumber': _userDetails['phnnumber'] ?? 'Unknown',
      'address': _userDetails['address'] ?? 'Unknown',
    };
    final paymentDetails = {
      'orderId': response.orderId,
      'paymentId': response.paymentId,
      'signature': response.signature,
    };

    directOrderNotifier.placeDirectOrder(widget.uid, widget.productDetails, paymentDetails, userDetails).then((_) {
      _showOrderConfirmationDialog();
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed: ${response.message}")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("External wallet selected: ${response.walletName}")));
  }

  void openCheckout(double price) {
    double amount = price * 100;

    var options = {
      'key': 'rzp_test_GcZZFDPP0jHtC4',
      'amount': amount,
      'name': 'VRStore',
      'description': 'Virtual Reality Gadgets',
      'prefill': {
        'contact': '9383424792',
        'email': 'vrstore@gmail.com'
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
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          _userDetails = doc.data() as Map<String, dynamic>;
        });
      }
    } on FirebaseAuthException catch(e){
                  List err=e.toString().split("]");

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err[1])));
    }
  }

  void _handleCODPayment() {
    final directOrderNotifier = Provider.of<DirectOrderNotifier>(context, listen: false);
    final userDetails = {
      'userName': _userDetails['name'] ?? 'Unknown',
      'phoneNumber': _userDetails['phoneNumber'] ?? 'Unknown',
      'address': _userDetails['address'] ?? 'Unknown',
    };
    final paymentDetails = {
      'paymentMethod': 'Cash on Delivery',
    };

    directOrderNotifier.placeDirectOrder(widget.uid, widget.productDetails, paymentDetails, userDetails).then((_) {
      _showOrderConfirmationDialog();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cash on Delivery order placed.")));

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserDetails(widget.uid);
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
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'User Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: GoogleFonts.ralewayDots().fontFamily),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Name: ${_userDetails['name'] ?? 'Unknown'}', style: TextStyle(fontFamily: GoogleFonts.ralewayDots().fontFamily),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Phone Number: ${_userDetails['phnnumber'] ?? 'Unknown'}', style: TextStyle(fontFamily: GoogleFonts.ralewayDots().fontFamily),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Address: ${_userDetails['address'] ?? 'Unknown'}' , style: TextStyle(fontFamily: GoogleFonts.ralewayDots().fontFamily),),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Product Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),
              ),
            ),
            ListTile(
              title: Text(widget.productDetails['modelname'] ?? 'Unknown' ,style: TextStyle(fontFamily: GoogleFonts.ralewayDots().fontFamily)),
              subtitle: Text('Price: ${widget.productDetails['price'] ?? 'Unknown'}' ,style: TextStyle(fontFamily: GoogleFonts.ralewayDots().fontFamily)),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Price: ${widget.productDetails['price']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: GoogleFonts.ralewayDots().fontFamily),
              ),
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      openCheckout(widget.productDetails['price']);
                    },
                    child: const Text('Pay with Razorpay'),
                  ),
                  ElevatedButton(
                    onPressed: _handleCODPayment,
                    child: const Text('Cash on Delivery'),
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
