import 'package:flutter/material.dart';

import '../../services/firebase.dart';

class MonthlyExpenses extends StatefulWidget {
  Map<String, dynamic>? allRecord;

  MonthlyExpenses({this.allRecord});

  @override
  State<MonthlyExpenses> createState() => _MonthlyExpensesState();
}

class _MonthlyExpensesState extends State<MonthlyExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.allRecord!.length,
        itemBuilder: (BuildContext context, int index) {
          String key = widget.allRecord!.keys.elementAt(index);
          String value= widget.allRecord!.values.elementAt(index).toString();

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
                      Text(value),
                      Spacer(),
                      Text(key),

                    ],
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
