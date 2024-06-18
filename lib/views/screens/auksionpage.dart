import 'package:auksion_app/controllers/cartcontroller.dart';
import 'package:auksion_app/models/product.dart';
import 'package:auksion_app/views/widgets/aboutphot.dart';
import 'package:auksion_app/views/widgets/timerwidget.dart'; // Adjust import path if needed
import 'package:flutter/material.dart';

class AuksionPage extends StatefulWidget {
  final Product product;
  final String id;

  AuksionPage({super.key, required this.product, required this.id});

  @override
  State<AuksionPage> createState() => _AuksionPageState();
}

class _AuksionPageState extends State<AuksionPage> {
  final CartController cartController = CartController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<int> prices = [];
  bool _isAuctionEnded = false; // Track auction status

  void _onTimerEnd() {
    // Perform any action when the timer ends
    setState(() {
      _isAuctionEnded = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Auction has ended!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: Aboutphot(product: widget.product),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CountdownTimer(
                      endTime: DateTime.parse(widget.product.auksiontime),
                      onTimerEnd: _onTimerEnd,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Current Price: ${widget.product.startprice}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: priceController,
                      validator: (value) {
                        if (_isAuctionEnded) {
                          return "Auksion tugagan,auksion tugagan payt siz stavka qilomaysiz";
                        }
                        if (value == null || value.isEmpty) {
                          return "Iltimos narh kirg`izing";
                        }
                        int? inputPrice = int.tryParse(value);
                        if (inputPrice == null ||
                            inputPrice <= widget.product.startprice) {
                          return 'Iltimos hozirgi nargdan balandroq kirg`zing!';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.monetization_on),
                        labelText: 'Narh kirg`iizng!',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      enabled: !_isAuctionEnded,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: _isAuctionEnded
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                int newPrice = int.parse(priceController.text);
                                cartController.addToCart(widget.product);
                                setState(() {
                                  prices.add(newPrice);
                                  widget.product.startprice = newPrice;
                                  priceController.clear();
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Narh muvaqiyatli almashdi!'),
                                  ),
                                );
                              }
                            },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Place Bid',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${widget.product.name}ning sotvular tarixi:',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: prices
                          .map(
                            (price) => Text(
                              'Nath: $price',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
