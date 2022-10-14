import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/screens/produts_admin.dart';

import 'orders_admin.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with TickerProviderStateMixin {
  late TabController tab;

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.edit),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.power_settings_new),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, '/register');
              },
            ),
            bottom: TabBar(
              tabs: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.inventory_2),
                ),
                Icon(Icons.content_paste)
              ],
              controller: tab,
            ),
          ),
          body: TabBarView(
            controller: tab,
            children: const [ProductsAdmin(), OrdersAdmin()],
          )),
    );
  }
}