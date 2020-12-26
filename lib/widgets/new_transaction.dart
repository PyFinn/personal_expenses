import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _selectedDate;

  void submitTransaction(BuildContext context) {
    try {
      double.parse(amountInput);
    } catch (Error) {
      return;
    }
    if (titleInput != null && amountInput != null && _selectedDate != null) {
      widget.addNewTransaction(DateTime.now().toString(), titleInput, amountInput, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  String titleInput;

  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                titleInput = value;
              },
              onSubmitted: (_) => submitTransaction(context),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(signed: true),
              onChanged: (value) {
                amountInput = value;
              },
              onSubmitted: (_) => submitTransaction(context),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(_selectedDate))),
                  FlatButton(
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                    child: Text(
                      'Choose Date!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                submitTransaction(context);
              },
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).buttonColor,
            )
          ],
        ),
      ),
    );
  }
}
