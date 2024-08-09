import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/shoes.dart';
import 'package:shoes_shop/data/model/users.dart';
import 'package:shoes_shop/screen/auth_screen.dart';
import 'package:shoes_shop/screen/cart_screen.dart';
import 'package:shoes_shop/screen/detail_screen.dart';
import 'package:shoes_shop/screen/favorite_screen.dart';
import 'package:shoes_shop/screen/home_screen.dart';
import 'package:shoes_shop/screen/login_screen.dart';
import 'package:shoes_shop/screen/main_screen.dart';
import 'package:shoes_shop/screen/profile_screen.dart';
import 'package:shoes_shop/screen/search_screen.dart';
import 'package:shoes_shop/screen/sign_up_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => ShoesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/main": (context) => MainScreen(),
        "/auth": (context) => AuthScreen(),
        "/login": (context) => LoginScreen(),
        "/signup": (context) => SignUp(),
        "/home": (context) => HomeScreen(),
        "/fav": (context) => FavoriteScreen(),
        "/cart": (context) => CartScreen(),
        "/profile": (context) => ProfileScreen(),
        "/detail": (context) => DetailScreen(),
        "/search": (context) => SearchScreen(),
      },
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future _navigateToNextPage() async {
    var delay = Duration(seconds: 3);
    await Future.delayed(
      delay,
      () {},
    );

    Navigator.pushReplacementNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.darken),
            image: AssetImage('assets/background.png'),
          ),
        ),
        child: Center(
          child: Text(
            "SHOES STORE",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
