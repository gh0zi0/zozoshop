import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/t_button.dart';

import 'bottom_sheet_product.dart';

class ListTileCustomPA extends StatelessWidget {
  ListTileCustomPA({super.key, required this.list, required this.index});
  List<QueryDocumentSnapshot<Object?>>? list;
  int index;

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
            subtitle: Text('${list![index]['price']} JOD'),
            title: Text(list![index]['title']),
            leading: list![index]['image'].toString().isEmpty
                ? const Icon(Icons.photo)
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(list![index]['image'].toString()),
                  ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  builder: (context) {
                    return BottomSheetProduct(data: list, index: index);
                  },
                );
              },
            ),
          )),
    );
  }
}
