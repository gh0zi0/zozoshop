import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/list_tile_order.dart';
import '../components/list_tile_product_admin.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({super.key});

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final orderData = snapshot.data?.docs;
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: orderData!.length,
              itemBuilder: (context, index) {
                return ListTileCustomOA(
                  list: orderData,
                  index: index,
                );
              },
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 110, 213, 194)));
      },
    );
  }
}
