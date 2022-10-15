import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zozoshop/components/e_button.dart';
import '../models/cart.dart';

class BottomSheetCart extends StatefulWidget {
  BottomSheetCart({super.key, required this.data, required this.total});
  List<Cart> data;
  double total;

  @override
  State<BottomSheetCart> createState() => _BottomSheetCartState();
}

class _BottomSheetCartState extends State<BottomSheetCart> {
  var loading = false, userId;
  final cart = Get.put(Cart(price: 0));

  orderNow() async {
    setState(() {
      loading = true;
    });
    userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'orderId': DateTime.now().microsecondsSinceEpoch,
        'timestamp': DateTime.now().toIso8601String(),
        'total': widget.total,
        'userId': userId,
        'products': widget.data
            .map((cp) => {
                  'title': cp.title,
                  'price': cp.price,
                })
            .toList(),
      });
      cart.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order done :)')));
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Cart details',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      cart.clear();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.data[index].title}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${widget.data[index].price} JOD',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    })),
            Divider(
              height: 20,
              thickness: 1,
            ),
            Text(
              'Total: ${widget.total} JOD',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            loading
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 110, 213, 194),
                  )
                : EButton(title: 'Order now', function: orderNow)
          ],
        ),
      ),
    );
  }
}
