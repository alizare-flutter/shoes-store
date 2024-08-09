import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/splitNumbers.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Iconsax.arrow_left_2),
        ),
        title: Text("My Cart"),
        centerTitle: true,
      ),
      body: Consumer<ShoesProvider>(
        builder: (context, shoesProvider, child) {
          List<Shoes> cartShoes =
              shoesProvider.shoesList.where((shoe) => shoe.addToCart).toList();
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: _getCartView(cartShoes),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<ShoesProvider>(
          builder: (context, shoesProvider, child) => Container(
            height: 254,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Total Cost",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Text(
                          '\$${SplitNumbers(shoesProvider.getTotalPrice().toInt())}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Container(
                          width: 333,
                          height: 378,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              Text(
                                "🎉",
                                style: TextStyle(fontSize: 100),
                              ),
                              SizedBox(height: 24),
                              Container(
                                width: 159,
                                height: 56,
                                child: Text(
                                  "Your Payment Is Successful",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.popUntil(
                                  //   context,
                                  //   ModalRoute.withName('/main'),
                                  // );
                                },
                                child: Text("Back To Shopping"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(300, 62),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(300, 62),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCartView(List<Shoes> cartShoes) {
    return ListView.builder(
      itemCount: cartShoes.length,
      itemBuilder: (context, index) {
        int _select = cartShoes[index].selectShoe;
        return Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.network(cartShoes[index].image[0], width: 100, height: 100),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartShoes[index].name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      SplitNumbers(cartShoes[index].price[_select].toInt()),
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              if (cartShoes[index].selectedCount > 0) {
                                setState(() {
                                  --cartShoes[index].selectedCount;
                                });
                              }
                            },
                            icon: Icon(Iconsax.minus),
                            iconSize: 24,
                            color: Colors.grey,
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(cartShoes[index].selectedCount.toString()),
                        SizedBox(width: 16),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                cartShoes[index].selectedCount++;
                              });
                            },
                            icon: Icon(Iconsax.add),
                            style: IconButton.styleFrom(
                              iconSize: 24,
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    cartShoes[index].size[0].toInt().toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<ShoesProvider>(context, listen: false)
                            .removeShoeFromCart(index);
                      });
                    },
                    icon: Icon(Iconsax.trash),
                    iconSize: 24,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
