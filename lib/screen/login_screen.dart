import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/users.dart';
import 'package:shoes_shop/screen/main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, this.toggleForm});
  final Function? toggleForm;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Hello Again!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Welcome Back You’ve Been Missed!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 50),
          _getTextFilds(),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Users? firstWhereOrNull(
                  List<Users> list, bool Function(Users) test) {
                for (Users user in list) {
                  if (test(user)) {
                    return user;
                  }
                }
                return null;
              }

              String email = _emailController.text;
              String password = _passwordController.text;

              UsersProvider usersProvider =
                  Provider.of<UsersProvider>(context, listen: false);
              Users? user = firstWhereOrNull(
                usersProvider.users,
                (user) => user.email == email && user.password == password,
              );

              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      user: user,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invalid credentials!')),
                );
              }
            },
            child: Text('Sign In'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(0),
              minimumSize: Size(double.infinity, 54),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Don\'t Have An Account?',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              TextButton(
                onPressed: () => widget.toggleForm!(),
                child: Text(
                  'Sign Up For Free',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getTextFilds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email Address",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Text(
          "Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
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
    );
  }
}
