import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double percentageByTotal;
  const ChartBar(this.amount, this.day, this.percentageByTotal);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FittedBox(child: Text('${amount.toInt()}')),
      const SizedBox(
        height: 4,
      ),
      Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: percentageByTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          )),
      const SizedBox(
        height: 4,
      ),
      Text(day),
    ]);
  }
}
