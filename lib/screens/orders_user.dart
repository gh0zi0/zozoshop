import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../components/list_tile_order.dart';

class OrdersUser extends StatefulWidget {
  const OrdersUser({super.key});

  @override
  State<OrdersUser> createState() => _OrdersUserState();
}

class _OrdersUserState extends State<OrdersUser> {
  var userId;

  @override
  void initState() {
    userId = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final orderData = snapshot.data?.docs;

        if (snapshot.hasData) {
          if (orderData!.isEmpty) {
            return Center(
              child: Lottie.asset('lottie/empty.json', height: 200, width: 200),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: orderData.length,
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
