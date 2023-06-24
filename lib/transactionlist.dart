import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.66,
      child: ListView.builder(
          itemBuilder: ((context, index) {
            return Container(
              padding:const EdgeInsets.all(2),
              child: Container(
                  child: Card(
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(children: [
                        Container(
                          margin: const EdgeInsets.all(7),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red,
                            child: FittedBox(
                                child: Text(
                              "₹${transactions[index].amount.toInt()}",
                              style: const TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactions[index].title,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .add_jm()
                                    .format(transactions[index].date),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    IconButton(
                        onPressed: () {
                          deleteTx(transactions[index].id.toString());
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
              )),
            );
          }),
          itemCount: transactions.length),
    );
  }
}
