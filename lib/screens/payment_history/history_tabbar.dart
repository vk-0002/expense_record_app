import 'package:flutter/material.dart';
import 'package:money_spend_app/screens/payment_history/dayli_expensec.dart';
import 'package:money_spend_app/screens/payment_history/monthly_expenses.dart';
import 'package:money_spend_app/screens/payment_history/yearly_expenses.dart';
import 'package:money_spend_app/screens/widgets/loading_screen.dart';
import 'package:money_spend_app/services/firebase.dart';

class HistoryTabBar extends StatefulWidget {
  const HistoryTabBar({Key? key}) : super(key: key);

  @override
  State<HistoryTabBar> createState() => _HistoryTabBarState();
}

class _HistoryTabBarState extends State<HistoryTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  Map<String, dynamic> allRecord = {};
  Map<String, dynamic> monthsTotal = {};
  Map<String, dynamic> yearsTotal = {};
  double total = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    Future.delayed(Duration.zero, () async {
      // Your Function


      getData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Daily",
            ),
            Tab(
              text: "Monthly",
            ),
            Tab(
              text: "Yearly",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[


          DailyExpenses(allRecord: allRecord,),

          MonthlyExpenses(allRecord: monthsTotal,),

          YearlyExpenses(allRecord: yearsTotal,),
        ],
      ),
    );
  }

  Future<void> getData() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        ));

    allRecord = await Database().getData();
    await calculateData();

    Navigator.of(context).pop();

    setState(() {});
  }

  Future calculateData() async {
    allRecord.forEach((key, value) {
      print(value);

      DateTime dateTime =
          DateTime.parse(value["dateTime"].toString().replaceAll("_", ":"));

      if (monthsTotal.containsKey(
          dateTime.month.toString() + '/' + dateTime.year.toString())) {
        monthsTotal[
                dateTime.month.toString() + '/' + dateTime.year.toString()] +=
            double.parse(value!["Cost"].toString());
      } else {
        monthsTotal[dateTime.month.toString() +
            '/' +
            dateTime.year.toString()] = double.parse(value!["Cost"].toString());
      }
    });

    allRecord.forEach((key, value) {
      DateTime dateTime =
          DateTime.parse(value["dateTime"].toString().replaceAll("_", ":"));

      if (yearsTotal.containsKey(dateTime.year.toString())) {
        yearsTotal[dateTime.year.toString()] +=
            double.parse(value!["Cost"].toString());
        total += double.parse(value!["Cost"].toString());
      } else {
        yearsTotal[dateTime.year.toString()] =
            double.parse(value!["Cost"].toString());
        total += double.parse(value!["Cost"].toString());
      }
    });
  }
}
