import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/wishlist.dart';
import 'package:flutter_assignment/provider/auth_provider.dart';
import 'package:flutter_assignment/provider/database_provider.dart';
import 'package:flutter_assignment/screens/add_wishlist.dart';
import 'package:flutter_assignment/screens/login.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var loading = true;
  @override
  void didChangeDependencies() {
    final databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);

    databaseProvider.getWishlistData().then((value) {
      setState(() {
        loading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final wishListData =
        Provider.of<DatabaseProvider>(context, listen: false).getWishList;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wishlist Tracker"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                // logout user
                authProvider.signout().then((value) =>
                    {Navigator.of(context).pushReplacementNamed(LoginScreen.routeName)});
              },
            ),
          ],
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: wishListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return WishList(
                    wishListData[index].name,
                    wishListData[index].description,
                    wishListData[index].price,
                    wishListId: wishListData[index].wishListId,
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToForm(context);
          },
          child: const Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

void navigateToForm(BuildContext context) {
  Navigator.of(context).pushNamed(WishlistFormScreen.routeName);
}
