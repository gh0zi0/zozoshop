import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zozoshop/screens/orders_user.dart';
import 'package:zozoshop/screens/products_user.dart';

import '../components/bottom_sheet_cart.dart';
import '../models/cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tab;
  final cart = Get.put(Cart(price: 0));

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: Badge(
                    badgeContent: Text(cart.items.length.toString()),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return BottomSheetCart(
                                data: cart.items.values.toList(),
                                total: cart.totalAmount);
                          },
                        );
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    )),
              )
            ],
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color.fromARGB(255, 110, 213, 194),
            leading: IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register', (route) => false);
              },
            ),
            bottom: TabBar(
              tabs: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.inventory_2,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.content_paste,
                  color: Colors.black,
                )
              ],
              controller: tab,
            ),
          ),
          body: TabBarView(
            controller: tab,
            children:  [ProductsUser(function:refresh), OrdersUser()],
          )),
    );
  }
}
