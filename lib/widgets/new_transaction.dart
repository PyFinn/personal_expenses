import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);


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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                amountInput = value;
              },
            ),
            FlatButton(
              onPressed: () {
                addNewTransaction(titleInput, amountInput);
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
