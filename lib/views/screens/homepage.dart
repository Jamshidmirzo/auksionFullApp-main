import 'package:auksion_app/views/screens/cartpage.dart';
import 'package:auksion_app/views/screens/homescreen.dart';
import 'package:auksion_app/views/screens/profilepage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Widget> screens = [
    const Homescreen(),
    const CartPage(),
    const Profilepage(),
  ];

  int _choiceIndex = 0;

  void _changeIndex(int index) {
    setState(() {
      _choiceIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: _choiceIndex,
        onTap: _changeIndex,
        selectedItemColor: Theme.of(context).colorScheme.onInverseSurface,
        unselectedItemColor: Theme.of(context).colorScheme.inverseSurface,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: context.tr('home')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart), label: context.tr('product')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: context.tr('profile')),
        ],
      ),
      body: screens[_choiceIndex],
    );
  }
}
