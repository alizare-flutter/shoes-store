import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/model/users.dart';
import 'package:shoes_shop/data/splitNumbers.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.shoes, this.user});

  List<Shoes>? shoes;
  Users? user;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _advancedDrawerController = AdvancedDrawerController();

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color.fromARGB(255, 26, 37, 48)),
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.fastEaseInToSlowEaseOut,
        animationDuration: const Duration(milliseconds: 300),
        childDecoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Shoes Store",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Iconsax.menu,
                    ),
                  );
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Iconsax.shopping_bag),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    maxLines: 1,
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _isSearching = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintMaxLines: 1,
                      label: Text(
                        "Looking for Shoes",
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: Icon(Iconsax.search_normal),
                    ),
                  ),
                  _isSearching
                      ? Expanded(child: _buildSearchResults(context))
                      : _buildMainContent(context),
                ],
              ),
            ),
          ),
        ),
        drawer: _getDrawer());
  }

  Widget _buildSearchResults(BuildContext context) {
    return Expanded(
      child: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) {
          String query = _searchController.text.toLowerCase();
          var filteredShoes = shoesProvider.shoesList.where((shoe) {
            return shoe.name.toLowerCase().contains(query);
          }).toList();
          return _getSearch(filteredShoes);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _getSearch(List<Shoes> filteredShoes) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: filteredShoes.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: filteredShoes[index],
              );
            },
            child: Container(
              height: 203,
              width: 156,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    filteredShoes[index].image[0],
                    width: 125,
                    height: 81,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: Text("Best Seller"),
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    child: Text(filteredShoes[index].name),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    child: Text(
                      SplitNumbers(filteredShoes[index].price[0].toInt()),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Shoes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "see all",
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 230,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: widget.shoes!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _getPopularShoes(
                  widget.shoes![index],
                  context,
                  index,
                ),
              );
            },
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Arrivals",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "see all",
                  style: TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        _getNewShoes(widget.shoes![0]),
      ],
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Widget _getNewShoes(Shoes shoe) {
    String name = shoe.name;
    String image = shoe.image[0];
    double price = shoe.price[0];
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: shoe);
      },
      child: Container(
        width: 400,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BEST CHOICE",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    SplitNumbers(price.toInt()),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Image.network(
              width: 127,
              height: 80,
              image,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPopularShoes(Shoes shoe, context, index) {
    String name = shoe.name;
    String image = shoe.image[0];
    double price = shoe.price[0];

    return IntrinsicHeight(
      child: Container(
        width: 175,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/detail',
              arguments: widget.shoes![index],
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                width: 137,
                height: 97,
                image,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Best Seller",
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 15.4, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            SplitNumbers(price.toInt()),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 34,
                      height: 35.5,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDrawer() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Container(
              width: 64.0,
              height: 64.0,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/user.png'),
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.only(left: 20.0, bottom: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey👋",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Text(
                  widget.user!.name,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            leading: Icon(Iconsax.user),
            title: Text('Profile'),
          ),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
            leading: Icon(Iconsax.home),
            title: Text('Home Page'),
          ),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
            leading: Icon(Iconsax.bag_2),
            title: Text('My Cart'),
          ),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
            leading: Icon(Iconsax.heart),
            title: Text('Favorite'),
          ),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
            leading: Icon(Iconsax.truck_fast),
            title: Text("Orders"),
          ),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {},
            leading: Icon(Iconsax.notification),
            title: Text("Notifications"),
          ),
          SizedBox(height: 50),
          Divider(
            indent: 20,
            color: Colors.grey,
            endIndent: 147,
          ),
          SizedBox(height: 50),
          ListTile(
            iconColor: Colors.grey,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/auth');
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
