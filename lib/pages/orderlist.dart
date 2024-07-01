import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrstore/provider/cartprovider.dart';
import 'package:vrstore/provider/userprovider.dart';


class OrderListPage extends StatelessWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          cartNotifier.fetchCartItems(userId); // Fetch order items for the user
          
          if (cartNotifier.cartItems.isEmpty) {
            return const Center(child: Text("No orders available"));
          } else {
            final items = cartNotifier.cartItems;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Price: \$${item['price']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
