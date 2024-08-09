import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/splitNumbers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                TextField(
                  maxLines: 1,
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    label: Text(
                      "Looking for Shoes",
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: Icon(Iconsax.search_normal),
                  ),
                ),
                Expanded(
                  child: Consumer<ShoesProvider>(
                    builder: (context, shoesProvider, child) {
                      String query = _searchController.text.toLowerCase();
                      var filteredShoes = shoesProvider.shoesList.where((shoe) {
                        return shoe.name.toLowerCase().contains(query);
                      }).toList();
                      return _getSearch(filteredShoes);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSearch(searchShoes) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: searchShoes.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: searchShoes[index],
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
                    searchShoes[index].image[0],
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
                    child: Text(searchShoes[index].name),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    child: Text(
                      SplitNumbers(searchShoes[index].price[0].toInt()),
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

  /*Future<void> _fiterList(String enteredKeyword) async {
    List<ShoesProvider> cryptoResultList = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        _isSearchLoadingVisible = true;
      });

      setState(() {
        _isSearchLoadingVisible = false;
      });
      return;
    }
    cryptoResultList = ShoesProvider!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();

    setState(() {
      cryptoList = cryptoResultList;
    });
  }*/
}
