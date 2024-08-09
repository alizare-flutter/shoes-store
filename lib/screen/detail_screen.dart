import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/splitNumbers.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectSize = 0;

  @override
  Widget build(BuildContext context) {
    final Shoes shoes = ModalRoute.of(context)!.settings.arguments as Shoes;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Iconsax.arrow_left_2),
        ),
        title: Text("Detail"),
        centerTitle: true,
        actions: [
          Consumer<ShoesProvider>(
            builder: (context, shoesProvider, child) {
              return IconButton(
                icon: Icon(
                  shoes.favShoe ? Icons.favorite : Icons.favorite_border,
                  color: shoes.favShoe ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    shoesProvider.toggleFavorite(shoes);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(shoes.favShoe
                          ? '${shoes.name} is now your favorite shoe!'
                          : "${shoes.name} not your favorite shoe now!"),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: PageView.builder(
                  itemCount: shoes.image.length,
                  itemBuilder: (context, index) => Image.network(
                    shoes.image[index],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Best Seller",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    Text(
                      "${shoes.name}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 12),
                    Text(
                      SplitNumbers(shoes.price[0].toInt()),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8),
                    DescriptionTextWidget(
                      text: shoes.subTitle,
                    ),
                    SizedBox(
                      height: 56,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                        itemCount: shoes.image.length,
                        itemBuilder: (context, index) =>
                            _getGallery(shoes.image[index], index),
                      ),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 60,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                        itemCount: shoes.size.length,
                        itemBuilder: (context, index) {
                          return _getSizes(shoes.size[index], index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 94,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Price:",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  Text(
                    SplitNumbers(shoes.price[_selectSize].toInt()),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Consumer<ShoesProvider>(
                builder: (context, shoesProvider, child) => ElevatedButton(
                  onPressed: () {
                    setState(() {
                      shoesProvider.addToCart(shoes);
                    });
                  },
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(167, 54),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getGallery(String shoe, int index) {
    return Container(
      height: 94,
      width: 56,
      child: Center(
        child: Image.network(shoe),
      ),
    );
  }

  Widget _getSizes(double size, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectSize = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _selectSize == index ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              size.toString(),
              style: TextStyle(
                color: _selectSize == index ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf = '';
  String secondHalf = '';

  bool flag = true;
  void checkText() {
    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  void initState() {
    super.initState();
    checkText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: [
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: TextStyle(
                      fontSize: 16, color: flag ? Colors.grey : Colors.black),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
