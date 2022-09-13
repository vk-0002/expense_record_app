import 'package:flutter/material.dart';

class YearlyExpenses extends StatefulWidget {
  Map<String, dynamic>? allRecord;

  YearlyExpenses({this.allRecord});

  @override
  State<YearlyExpenses> createState() => _YearlyExpensesState();
}

class _YearlyExpensesState extends State<YearlyExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
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
