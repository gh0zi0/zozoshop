import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/list_tile_product_admin.dart';

class ProductsAdmin extends StatefulWidget {
  const ProductsAdmin({super.key});

  @override
  State<ProductsAdmin> createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final productData = snapshot.data?.docs;
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: productData!.length,
              itemBuilder: (context, index) {
                return ListTileCustomPA(
                  list: productData,
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
