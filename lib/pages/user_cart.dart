

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/pages/confirm_payment.dart';
import 'package:vrstore/provider/cartprovider.dart';
import 'package:vrstore/provider/userprovider.dart';

class PageUserCart extends StatelessWidget {
  const PageUserCart({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.user?.uid;

    if (userId == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final cartNotifier = Provider.of<CartNotifier>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartNotifier.fetchCartItems(userId);
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Cart >>",
                  style: TextStyle(
                    fontFamily: GoogleFonts.kronaOne().fontFamily,
                  ),
                ),
              ),
            ),
            Consumer<CartNotifier>(
              builder: (context, cartNotifier, child) {
                if (cartNotifier.cartItems.isEmpty) {
                  return const Center(child: Text('No Items in Cart'));
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartNotifier.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartNotifier.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child:  SizedBox(
                                    height: 80,
                                    child: ClipRRect(
                                      child: Image.network(item['url'] ?? 'No name'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              item['modelname'] ?? 'No name',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: GoogleFonts.kronaOne().fontFamily,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Opacity(
                                                opacity: 0.8,
                                                child: Text(
                                                  item['companyname'] ?? 'No name',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Opacity(
                                                    opacity: 0.5,
                                                    child: Text(
                                                      "Rs.",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item['price'] ?? 'No name',
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: GoogleFonts.kronaOne().fontFamily,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () {

                                        cartNotifier.removeFromCart(userId, item['id']);
                                      },
                                      child: const Text("Remove"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        color: Theme.of(context).colorScheme.background,
        child: Consumer<CartNotifier>(
          builder: (context, cartNotifier, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total Price: Rs. ${cartNotifier.getTotalPrice().toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: GoogleFonts.kronaOne().fontFamily,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(uid: userId, totalPrice: cartNotifier.getTotalPrice()),));
                    },
                    child: const Text("Buy All"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
