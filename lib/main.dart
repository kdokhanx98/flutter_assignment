import 'package:flutter/material.dart';
import 'package:flutter_assignment/provider/auth_provider.dart';
import 'package:flutter_assignment/provider/database_provider.dart';
import 'package:flutter_assignment/screens/add_wishlist.dart';
import 'package:flutter_assignment/screens/edit_wishlist.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(
          create: (_) => AuthProvider(),
        ),
        ListenableProvider(
          create: (_) => DatabaseProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wishlist Tracker',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const LoginScreen(),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          WishlistFormScreen.routeName: (context) => const WishlistFormScreen(),
          EditWishlistScreen.routeName: (context) => const EditWishlistScreen(),
        },
      ),
    );
  }
}
