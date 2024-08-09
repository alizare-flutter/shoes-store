import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/data/model/users.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key, this.toggleForm});
  final Function? toggleForm;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Create Account",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Let’s Create Account Together",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 50),
          _getTextFiled("You'r Name", nameController, true),
          SizedBox(height: 12),
          _getTextFiled("Email Address", emailController, true),
          SizedBox(height: 12),
          _getTextFiled("Password", passwordController, false),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              String name = nameController.text;
              String email = emailController.text;
              String password = passwordController.text;

              UsersProvider usersProvider =
                  Provider.of<UsersProvider>(context, listen: false);
              usersProvider.addUser(name, password, email, '');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registration successful!')),
              );

              widget.toggleForm!();
            },
            child: Text('Sign Up'),
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
                'Already have an account?',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              TextButton(
                onPressed: () => widget.toggleForm!(),
                child: Text(
                  'Login',
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

  Widget _getTextFiled(
      String Title, TextEditingController Controler, bool _isPassword) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.0),
          _isPassword
              ? TextField(
                  controller: Controler,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              : TextField(
                  controller: passwordController,
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
