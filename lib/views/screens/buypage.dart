

import 'package:auksion_app/models/product.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Buypage extends StatefulWidget {
  Product product;
  Buypage({super.key, required this.product});

  @override
  State<Buypage> createState() => _BuypageState();
}

class _BuypageState extends State<Buypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Buy page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  'Obyekt nomi: ',
                  style: TextStyle(fontSize: 23),
                ),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Obyekt narhi: ',
                  style: const TextStyle(fontSize: 23),
                ),
                Text(
                  "${widget.product.startprice} UZS",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sotib olish turlari',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bank orqali',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Online to`lov',
                    style: TextStyle(color: Colors.amber),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.inversePrimary),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bekor qilish',
                    style: TextStyle(color: Colors.amber),
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
