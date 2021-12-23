import 'package:flutter/material.dart';
import 'package:flutter_assignment/provider/auth_provider.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return FlutterLogin(
      title: "Wishlist Tracker",
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      },
      onLogin: (response) {
        authProvider.login();
      },
      onRecoverPassword: (res) {},
    );
  }
}
