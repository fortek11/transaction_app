import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'transaction.dart';
import 'transactionlist.dart';
import 'newtransaction.dart';
import 'chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MaterialApp(
    home: TransactionManager(),
    theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.red, primary: Colors.red),
        fontFamily: 'Poppins'),
  ));
}

class TransactionManager extends StatefulWidget {
  @override
  State<TransactionManager> createState() => _TransactionManagerState();
}

class _TransactionManagerState extends State<TransactionManager> {
  final List<Transaction> transactions = [
    Transaction('Test123', 100,
        DateTime.now().subtract(const Duration(days: 1)), 'sdasd1'),
    Transaction('Test124', 200, DateTime.now(), 'sdasd'),
    Transaction('Test125', 200,
        DateTime.now().subtract(const Duration(days: 1)), 'sdasd2'),
  ];

  List<Transaction> get recentTransactionss {
    return transactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void deleteTx(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: const Text("Transaction Deleted!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK", style: TextStyle(color: Colors.red)))
            ],
          );
        }));
  }

  void startModalBottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: NewTransaction(newTx),)
              ],
            )
          );
        });
  }

  void newTx(String title, double amount, DateTime finalDate) {
    final newTxx =
        Transaction(title, amount, finalDate, DateTime.now().toString());
    setState(() {
      transactions.add(newTxx);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.red, primary: Colors.red),
            fontFamily: 'Poppins'),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Transactions"),
            backgroundColor: Colors.red,
          ),
          body: transactions.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/istock-530583132.jpg',
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const Text(
                        'No Transactions! You Broke Af',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )
              : isLandscape == false
                  ? SingleChildScrollView(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Chart(recentTransactionss),
                        TransactionList(transactions, deleteTx),
                      ],
                    ))
                  : SingleChildScrollView(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Show Chart'),
                            Switch(
                                value: _showChart,
                                activeColor: Colors.red,
                                onChanged: (val) {
                                  setState(() {
                                    _showChart = val;
                                  });
                                }),
                          ],
                        ),
                        if (_showChart == true) Chart(recentTransactionss),
                        if (_showChart == false)
                          TransactionList(transactions, deleteTx),
                      ],
                    )),
          floatingActionButton: FloatingActionButton(
            onPressed: (() {
              startModalBottomsheet();
            }),
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
