import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/t_button.dart';

class ListTileCustom extends StatelessWidget {
  ListTileCustom({super.key, required this.list, required this.index});
  List<QueryDocumentSnapshot<Object?>>? list;
  int index;

  delete(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete the poduct?'),
          actions: [
            TButton(
                title: 'Yes',
                function: () async {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(list![index].id);
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
      onDismissed: (direction) {
        delete(context);
      },
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
            title: Text(list![index]['title']),
            leading: Icon(Icons.photo),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          )),
    );
  }
}
