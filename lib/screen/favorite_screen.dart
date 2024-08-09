import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/splitNumbers.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Iconsax.arrow_left_2)),
        centerTitle: true,
        title: Text("Favourite"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.heart,
            ),
          )
        ],
      ),
      body: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) {
          List<Shoes> favoriteShoes =
              shoesProvider.shoesList.where((shoe) => shoe.favShoe).toList();
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              itemCount: favoriteShoes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                Shoes shoe = favoriteShoes[index];
                return Padding(
                  padding: const EdgeInsets.all(5.5),
                  child: _getFavShoes(shoe),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getFavShoes(Shoes shoe) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: shoe);
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
              shoe.image[0],
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
              child: Text(shoe.name),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              child: Text(SplitNumbers(shoe.price[0].toInt())),
            )
          ],
        ),
      ),
    );
  }
}
