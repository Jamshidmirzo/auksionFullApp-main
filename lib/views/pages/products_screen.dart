import 'package:auksion_app/models/seller.dart';
import 'package:auksion_app/services/products_viewmodel.dart';
import 'package:auksion_app/views/pages/manage_products_screen.dart';
import 'package:auksion_app/views/pages/product_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productsViewModel = ProductsViewmodel();

  void addProduct() async {
    final response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return ManageProductsScreen(
            productsViewModel: productsViewModel,
          );
        },
      ),
    );
    if (response != null) {
      setState(() {});
    }
  }

  void editProduct(Product product) async {
    final response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return ManageProductsScreen(
            product: product,
            productsViewModel: productsViewModel,
          );
        },
      ),
    );

    if (response != null) {
      setState(() {});
    }
  }

  void deleteProduct(Product product) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Text("Siz ${product.title}'ni o'chirmoqchimisiz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("O'chirish"),
            ),
          ],
        );
      },
    );

    if (response) {
      productsViewModel.deleteProduct(product.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Admin Oynasi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: addProduct,
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder(
          future: productsViewModel.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Mahsulotlar mavjud emas"),
              );
            }

            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  onEdit: () {
                    editProduct(product);
                  },
                  onDelete: () {
                    deleteProduct(product);
                  },
                );
              },
            );
          }),
    );
  }
}
