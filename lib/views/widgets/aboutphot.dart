import 'package:flutter/material.dart';

class Aboutphot extends StatefulWidget {
  final product;
  const Aboutphot({super.key, required this.product});

  @override
  State<Aboutphot> createState() => _AboutphotState();
}

class _AboutphotState extends State<Aboutphot> {
  final _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      clipBehavior: Clip.none,
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      onPageChanged: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      itemCount: widget.product.images.length,
      itemBuilder: (context, index) {
        return Image.network(
          widget.product.images[index]['imageURL'] ??
              'https://autouzbek.com/assets/default_car-83e7841ce1a818a032ca9b6976bc3ddd51db34b92b646b4ddf5882dc66e2c089.jpg',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.access_alarm_outlined),
            );
          },
        );
      },
    );
  }
}
