import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zozoshop/components/e_button.dart';
import 'package:intl/intl.dart';
import 'edit_text.dart';

class BottomSheetOrder extends StatefulWidget {
  BottomSheetOrder({super.key, required this.data, required this.index});
  List<QueryDocumentSnapshot<Object?>>? data;
  int index;

  @override
  State<BottomSheetOrder> createState() => _BottomSheetOrderState();
}

class _BottomSheetOrderState extends State<BottomSheetOrder> {
  var orderId, timestamp, map, total;

  getCustomFormattedDateTime(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat('MM/dd/yy hh:mm').format(docDateTime);
  }

  @override
  void initState() {
    orderId = widget.data![widget.index]['orderId'];
    timestamp = getCustomFormattedDateTime(
        widget.data![widget.index]['timestamp'].toString());
    total = widget.data![widget.index]['total'];
    map = widget.data![widget.index]['products'];

    super.initState();
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
            Text(
              'Order details',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Order Id: ${orderId.toString().substring(10)} , Date: ${timestamp}',
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: map.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${map[index]['title']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${map[index]['price']} JOD',
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
              'Total: ${total} JOD',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
