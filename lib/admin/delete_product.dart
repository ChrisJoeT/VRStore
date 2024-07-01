import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vrstore/provider/productprovider.dart' as productProvider;
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    await Provider.of<productProvider.ProductViewProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer<productProvider.ProductViewProvider>(
        builder: (context, productViewProvider, child) {
          if (productViewProvider.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: productViewProvider.products.length,
              itemBuilder: (context, index) {
                final product = productViewProvider.products[index];
                return ListTile(
                  leading: Image.network(product['url'] ?? 'https://via.placeholder.com/150'),
                  title: Text(product['modelname'] ?? 'No model name'),
                  subtitle: Text(product['companyname'] ?? 'No company name'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      bool success = await _deleteProduct(context, product['productid'] ?? '');
                      if (success) {
                        await _fetchProducts(); 
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<bool> _deleteProduct(BuildContext context, String productId) async {
    try {
      if (productId.isEmpty) return false;
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      return true;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }
}
