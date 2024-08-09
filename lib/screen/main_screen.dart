import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/model/users.dart';
import 'package:shoes_shop/screen/favorite_screen.dart';
import 'package:shoes_shop/screen/home_screen.dart';
import 'package:shoes_shop/screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key, this.user});

  Users? user;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    ShoesProvider shoesProvider = Provider.of<ShoesProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _bottomNavIndex,
        children: getLayout(context, shoesProvider),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        child: FloatingActionButton(
          child: Icon(Iconsax.bag_2),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 24,
        icons: [
          Iconsax.home,
          Iconsax.heart,
          Iconsax.notification,
          Iconsax.user,
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        activeColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> getLayout(BuildContext context, ShoesProvider shoesProvider) {
    return <Widget>[
      HomeScreen(
        shoes: shoesProvider.shoesList,
        user: widget.user!,
      ),
      FavoriteScreen(),
      Container(color: Colors.white),
      ProfileScreen(),
    ];
  }
}
