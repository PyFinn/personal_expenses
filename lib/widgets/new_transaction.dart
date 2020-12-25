import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  void submitTransaction(BuildContext context) {
    try {
      double.parse(amountInput);
    } catch (Error){
      return;
    }
    if (titleInput != null && amountInput != null) {
      addNewTransaction(titleInput, amountInput);
    }

    Navigator.of(context).pop();
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
            FlatButton(
              onPressed: () {
                submitTransaction(context);
              },
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
