import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/bottom_sheet_order.dart';
import 'package:zozoshop/components/t_button.dart';
import 'package:intl/intl.dart';
import 'bottom_sheet_product.dart';

class ListTileCustomOA extends StatelessWidget {
  ListTileCustomOA({super.key, required this.list, required this.index});
  List<QueryDocumentSnapshot<Object?>>? list;
  int index;

  getCustomFormattedDateTime(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat('MM/dd/yy hh:mm').format(docDateTime);
  }

  delete(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete the poduct?'),
          actions: [
            TButton(
                title: 'Yes',
                function: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(list![index].id)
                        .delete();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Product added')));
                  } on FirebaseException catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }),
            TButton(
                title: 'No',
                function: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(list![index].id),
      confirmDismiss: (direction) => delete(context),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.red.shade300,
        ),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
        ),
      ),
      child: Card(
          shape: const StadiumBorder(),
          child: ListTile(
            subtitle: Text(DateFormat('dd/MM/yyyy,hh:mm')
                .format(DateTime.parse(list![index]['timestamp']))),
            title: Text(
                'Order id: ${list![index]['orderId'].toString().substring(10)}'),
            trailing: IconButton(
              icon: const Icon(Icons.expand_circle_down),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  builder: (context) {
                    return BottomSheetOrder(data: list, index: index);
                  },
                );
              },
            ),
          )),
    );
  }
}
