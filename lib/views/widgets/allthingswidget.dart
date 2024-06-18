import 'package:auksion_app/controllers/productcontroller.dart';
import 'package:auksion_app/views/screens/aboutscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Allthingswidget extends StatefulWidget {
  const Allthingswidget({super.key});

  @override
  State<Allthingswidget> createState() => _AllthingswidgetState();
}

class _AllthingswidgetState extends State<Allthingswidget> {
  final productcontroller = ProductController();
  int selectedCategoryId = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: productcontroller.getProduct(selectedCategoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/lotties/loading.json',
                  width: 50, height: 50),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Mahsulotlarizm yoq'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product.images[0]['imageURL']),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: GoogleFonts.akatab(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Text('Boshlang`ich narhi'),
                          Text(
                            '${product.startprice} UZS',
                            style: const TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Aboutscreen(product: product);
                                  },
                                ),
                              );
                            },
                            child: const Text('Batafsil'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
