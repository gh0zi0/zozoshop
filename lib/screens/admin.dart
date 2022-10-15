import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/screens/produts_admin.dart';
import '../components/bottom_sheet_product.dart';
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
            backgroundColor: Color.fromARGB(255, 110, 213, 194),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                builder: (context) {
                  return BottomSheetProduct(
                    data: [],
                    index: 0,
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          appBar: AppBar(
            title: Text(
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
                Navigator.popAndPushNamed(context, '/register');
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
            children: const [ProductsAdmin(), OrdersAdmin()],
          )),
    );
  }
}
