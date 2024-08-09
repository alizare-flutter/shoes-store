import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/users.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _controlFullname = TextEditingController(text: _FullName);
  var _controlEmail = TextEditingController(text: _Email);
  var _controlPassword = TextEditingController(text: _Password);
  bool _obscureText = true;
  bool _isAval = false;
  static const String _FullName = "Ali Asghar Zare";
  static const String _Email = "alizare.flutter@gmail.com";
  static const String _Password = "password1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Iconsax.arrow_left_2),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isAval = !_isAval;
              });
            },
            icon: Icon(_isAval ? Iconsax.pen_close : Iconsax.edit_2),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child:
              Consumer<UsersProvider>(builder: (context, usersprovider, child) {
            return Column(
              children: [
                Container(
                  width: 92,
                  height: 100,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      Positioned(
                        top: 76,
                        bottom: 0,
                        left: 33,
                        right: 33,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Iconsax.camera),
                          style: IconButton.styleFrom(
                            iconSize: 20,
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Ali Asghar Zare",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 32),
                _getTextFiled("Full Name", _controlFullname, true),
                SizedBox(height: 16),
                _getTextFiled("Email Address", _controlEmail, true),
                SizedBox(height: 16),
                _getTextFiled("Password", _controlPassword, false),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _getTextFiled(
      String Title, TextEditingController Controler, bool _isPassword) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Title),
          SizedBox(height: 12.0),
          _isPassword
              ? TextField(
                  enabled: _isAval,
                  controller: Controler,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              : TextField(
                  enabled: _isAval,
                  controller: _controlPassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Iconsax.eye : Iconsax.eye_slash,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
