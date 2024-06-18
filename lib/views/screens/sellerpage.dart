import 'package:flutter/material.dart';

class Sellerpage extends StatefulWidget {
  const Sellerpage({super.key});

  @override
  State<Sellerpage> createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Seller page"),
      ),
    );
  }
}
