import 'package:flutter/material.dart';

class Shoes {
  String name;
  List<double> size;
  List<String> image;
  List<double> price;
  String subTitle;
  bool favShoe;
  bool addToCart;
  int selectedCount = 1;
  int selectShoe = 0;

  Shoes(this.name, this.size, this.image, this.price, this.subTitle,
      {this.favShoe = false, this.addToCart = false});
}

class ShoesProvider with ChangeNotifier {
  List<Shoes> _shoes = [
    Shoes(
      "Men's shoes model Bsh kV1",
      [41, 42, 43, 44],
      [
        "https://dkstatics-public.digikala.com/digikala-products/7c0a429b881219e4a96ab19f463970ac8f26be08_1700390404.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/6a139aafa8cd9c2eb13e73795a8939a48a0bd85d_1700389109.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/6256c7b070e46f5eefa5c5ff2104a4eba030adca_1700391171.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90"
      ],
      [590000, 590000, 549000, 490000],
      "BshkV11 shoes are a suitable choice for all those who want to have a durable and comfortable shoe for everyday use or parties in addition to an up-to-date and stylish style. It is all around the shoe, which has doubled its strength. The inside of the shoe is also made of towel fabric, which provides a sense of softness and comfort, and due to the breathable material, it can be used in summer and winter.",
    ),
    Shoes(
      "SH205 natural leather men's shoes",
      [40, 41, 42, 43, 44],
      [
        "https://dkstatics-public.digikala.com/digikala-products/4ce3122f96ba112986bab6d0a4bec0a97c1e4182_1718868400.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/55837c04eb76624810a2583e2fa0b86ac24fc546_1718868401.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/12c0bc91b76f84a81c9e62325438c33c43b4e760_1718868419.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/1b5dcb0e339410955f563845a85a5160206a2c57_1718868439.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/9014f48dc0859d7dcb15560a4cf76852d1be0321_1718868453.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/648367a717d488773073287577ce472ee83e099c_1718868449.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/234ccda60c3252a0d2adfaf871c6a9f7c0a1be8f_1718868452.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/ed46408a94e1dc745a323037db38fc8e7945e056_1718868474.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
      ],
      [2496800, 2496800, 2496800, 2496800, 2496800.9],
      "Atard leather brand luxury and casual shoes are produced from the most luxurious and special natural cow leather of Iran. The entire upper part of the shoe is made from the combination of "
          "Rustic natural cow leather and Atard leather brand croco"
          ". The lining inside the shoe is also made of the most luxurious natural goat leather so that your feet feel the most comfortable. Even the soles of the shoes are made of natural goat leather. All natural leather shoes of Atard brand are among the most luxurious natural leather shoes produced by this brand.",
    ),
    Shoes(
      "New Balance men's walking shoes",
      [45],
      [
        "https://dkstatics-public.digikala.com/digikala-products/35599ec7ee9e19d2c7abb90e16de1d6cbf1848c2_1674075021.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/7e765a43eec6fb1b383b8d78f0af0591b33ac70e_1674063938.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/5b790fe5fa1bf33e2d0402d63f603064fbf85455_1674063964.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/1893e15c756031bc2d699f00ccdb63427a50b005_1674063989.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90",
        "https://dkstatics-public.digikala.com/digikala-products/d2fbc2e8af65dff7cec88db5457b7856247c0129_1674063972.jpg?x-oss-process=image/resize,m_lfit,h_800,w_800/format,webp/quality,q_90"
      ],
      [42365000],
      "This original New Balance US 992 sneaker has an eye-catching look, with premium materials and distinctive features to make your look more special. These men's sneakers feature a soft Supima® upper on the SBS ABZORB heel and a rubber outsole for added durability and comfort.",
    ),
  ];

  List<Shoes> get shoesList => _shoes;

  void toggleFavorite(Shoes shoe) {
    int index = _shoes.indexOf(shoe);
    if (index != -1) {
      _shoes[index].favShoe = !_shoes[index].favShoe;
      notifyListeners();
    }
  }

  void addToCart(Shoes shoes) {
    int index = _shoes.indexOf(shoes);
    if (index != -1) {
      if (_shoes[index].addToCart == false) {
        _shoes[index].addToCart = true;
      } else {
        _shoes[index].selectedCount++;
      }
      notifyListeners();
    }
  }

  void removeShoeFromCart(int index) {
    shoesList[index].addToCart = false;
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var shoe in _shoes) {
      if (shoe.addToCart) {
        total += shoe.price[0] * shoe.selectedCount;
      }
    }
    return total;
  }
}
