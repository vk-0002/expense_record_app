import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../services/firebase.dart';

class DailyExpenses extends StatefulWidget {

  Map<String, dynamic>? allRecord;

  DailyExpenses({this.allRecord});



  @override
  State<DailyExpenses> createState() => _DailyExpensesState();
}

class _DailyExpensesState extends State<DailyExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.allRecord!.length,
        itemBuilder: (BuildContext context, int index) {
          String key = widget.allRecord!.keys.elementAt(index);
          DateTime dateTime = DateTime.parse(
              widget.allRecord![key]["dateTime"].toString().replaceAll("_", ":"));
          String date =
              "${dateTime.day}:${dateTime.month}:${dateTime.year}";
          double cost = double.parse(widget.allRecord![key]["Cost"].toString());

          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(widget.allRecord![key]["description"]),
                      Spacer(),
                      IconButton(
                          onPressed: () async {
                            await Database().deleteData(key);

                            setState(() {});
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("$cost rs"),
                      const Spacer(),
                      Text(date),
                    ],
                  ),
                  const Divider(
                    height: 2.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
