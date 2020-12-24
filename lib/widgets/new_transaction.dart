import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  void submitTransaction() {
    try {
      double.parse(amountInput);
    } catch (Error){
      return;
    }
    if (titleInput != null && amountInput != null) {
      addNewTransaction(titleInput, amountInput);
    }
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
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(signed: true),
              onChanged: (value) {
                amountInput = value;
              },
              onSubmitted: (_) => submitTransaction(),
            ),
            FlatButton(
              onPressed: () {
                submitTransaction();
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
