import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  void addTransaction() {
    widget.addTx(
        _textController.text, double.parse(_amountController.text), dateFinal);
  }

  DateTime dateFinal = DateTime(2000);
  void initiateDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now().add(const Duration(days: 1)))
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          dateFinal = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dateFinal == DateTime(2000)
                      ? 'Select A Date'
                      : DateFormat.yMMMd().format(dateFinal)),
                  TextButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        initiateDate();
                      },
                      child: const Text('Select Date')),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  addTransaction();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Add Transaction!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
