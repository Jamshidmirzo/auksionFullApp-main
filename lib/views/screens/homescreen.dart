import 'dart:convert';

import 'package:auksion_app/controllers/productcontroller.dart';
import 'package:auksion_app/views/screens/aboutscreen.dart';
import 'package:auksion_app/views/widgets/searchviewdelegate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final productcontroller = ProductController();
  int selectedCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.tr('categories')),
        actions: [
          IconButton(
            onPressed: () async {
              String? result = await showSearch(
                  context: context,
                  delegate: SearchViewDelegate(productcontroller.getProduct()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              context.tr('categories'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          FutureBuilder(
              future: productcontroller.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset('assets/lotties/loading.json',
                        width: 100, height: 100),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Category yoq'),
                  );
                }
                return SizedBox(
                  height: 70,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final category = snapshot.data![index];
                      return ZoomTapAnimation(
                        onTap: () {
                          setState(() {
                            selectedCategoryId = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          child: Text(
                            category,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
          Expanded(
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
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 120,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      product.images[0]['imageURL']),
                                ),
                                borderRadius: BorderRadius.circular(20),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(context.tr('start_price')),
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
                                ZoomTapAnimation(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Aboutscreen(
                                                product: product);
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(context.tr('detail')),
                                  ),
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
          ),
        ],
      ),
    );
  }
}
