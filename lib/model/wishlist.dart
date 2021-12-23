import 'package:flutter/material.dart';
import 'package:flutter_assignment/provider/database_provider.dart';
import 'package:flutter_assignment/screens/edit_wishlist.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String? wishListId;
  final int? index;

  // ignore: use_key_in_widget_constructors
  const WishList(this.name, this.description, this.price,
      {this.wishListId, this.index});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditWishlistScreen.routeName,
            arguments: WishList(widget.name, widget.description, widget.price,
                wishListId: widget.wishListId));
      },
      child: !isDeleting
          ? Container(
              height: height * 0.15,
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 15, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "Name: ",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.name,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Price: ",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '\$${widget.price}',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Description: ",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.description,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDeleting = !isDeleting;
                        });
                        Provider.of<DatabaseProvider>(context, listen: false)
                            .removeWishList(widget.wishListId!)
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Wishlist deleted successfully')),
                            );
                            setState(() {
                              isDeleting = !isDeleting;
                            });
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const HomeScreen(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Something went wrong :(')),
                            );
                          }
                        });
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        height: 20,
                        child: Center(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
