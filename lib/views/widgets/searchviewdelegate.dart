import 'package:auksion_app/models/product.dart';
import 'package:auksion_app/views/screens/aboutscreen.dart';
import 'package:flutter/material.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final Future<List<Product>> data;
  SearchViewDelegate(this.data);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This can be customized further based on what you want to show on results
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No Products Found'),
          );
        }

        final List<Product> products = snapshot.data!.where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase());
        }).toList();

        if (products.isEmpty) {
          return Center(
            child: Text('No Products Found'),
          );
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              onTap: () {
                close(context, product.name);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Aboutscreen(product: product),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
