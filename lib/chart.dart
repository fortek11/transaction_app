import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';
import 'chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  var totall = 0.0;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      totall += totalSum;
      print(DateFormat.E().format(weekDay));
      print(totalSum.toStringAsFixed(0));

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum.toStringAsFixed(0),
        'pct': double.parse((totalSum / totalOfall()).toString()),
      };
    }).toList();
  }

  double totalOfall() {
    var totallSum = 0.0;
    for (var i = 0; i < recentTransactions.length; i++) {
      totallSum += recentTransactions[i].amount;
    }
    print('total = ${totallSum}');
    return totallSum;
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    print(totall);
    totalOfall();
    return Container(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(double.parse(data['amount'].toString()),
                  data['day'].toString(), double.parse(data['pct'].toString())),
            );
          }).toList(),
        ),
      ),
    );
  }
}
