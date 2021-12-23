import 'package:flutter/material.dart';
import 'package:flutter_assignment/model/wishlist.dart';
import 'package:flutter_assignment/provider/database_provider.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:provider/provider.dart';

class WishlistFormScreen extends StatefulWidget {
  const WishlistFormScreen({Key? key}) : super(key: key);
  static const routeName = '/wishListForm';

  @override
  _WishlistFormScreenState createState() => _WishlistFormScreenState();
}

class _WishlistFormScreenState extends State<WishlistFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Wishlist")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.01),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your wishlist name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                keyboardType: TextInputType.multiline,
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Price', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: width * 0.4,
                    height: height * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          databaseProvider
                              .addWishlist(WishList(
                                  nameController.text,
                                  descriptionController.text,
                                  priceController.text))
                              .then((value) {
                            if (value) {
                              _formKey.currentState!.reset();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Wishlist added successfully!')),
                              );
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName);
                              setState(() {});
                            }
                          });
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    height: height * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName);
                      },
                      child: const Text('Wishlist'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
