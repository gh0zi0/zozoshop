import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/e_button.dart';

import 'edit_text.dart';

class BottomSheetProduct extends StatefulWidget {
  BottomSheetProduct({super.key, required this.data, required this.index});
  List<QueryDocumentSnapshot<Object?>>? data;
  int index;

  @override
  State<BottomSheetProduct> createState() => _BottomSheetProductState();
}

class _BottomSheetProductState extends State<BottomSheetProduct> {
  final GlobalKey<FormState> Gkey = GlobalKey();

  var title = TextEditingController(),
      price = TextEditingController(),
      image = TextEditingController(),
      loading = false,
      x = 'Add';

  product() async {
    if (!Gkey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = !loading;
    });

    try {
      if (x == 'Add') {
        await FirebaseFirestore.instance.collection('products').add({
          'title': title.text,
          'price': int.parse(price.text),
          'image': image.text
        });
      } else {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.data![widget.index].id)
            .set({
          'title': title.text,
          'price': int.parse(price.text),
          'image': image.text
        });
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product $x ed')));
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    if (widget.data!.length != 0) {
      title.text = widget.data![widget.index]['title'];
      price.text = widget.data![widget.index]['price'].toString();
      image.text = widget.data![widget.index]['image'];
      x = 'Edit';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      height: double.infinity,
      child: Form(
        key: Gkey,
        child: Column(
          children: [
            Text(
              '$x product',
              style: TextStyle(fontSize: 25),
            ),
            EditTextFiled(
              hint: 'Product name',
              icon: Icons.text_fields_outlined,
              controller: title,
              secure: false,
              validator: (val) {
                if (val!.isEmpty) return 'Please enter a product name';
              },
            ),
            EditTextFiled(
              hint: 'Product price',
              icon: Icons.monetization_on_sharp,
              controller: price,
              secure: false,
              validator: (val) {
                if (val!.isEmpty) return 'Please enter a product price';
              },
            ),
            EditTextFiled(
                hint: 'Image url',
                icon: Icons.photo,
                controller: image,
                secure: false,
                validator: null),
            const SizedBox(
              height: 50,
            ),
            loading
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 110, 213, 194))
                : EButton(title: x, function: product)
          ],
        ),
      ),
    );
  }
}
