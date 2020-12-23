import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New Shirt', amount: 29.99, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Pants', amount: 89.99, date: DateTime.now())
  ];

  void _addNewTransaction(String title, String amount) {
    setState(() {
      _transactions.add(Transaction(
          id: 't4',
          title: title,
          amount: double.parse(amount),
          date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [NewTransaction(_addNewTransaction), TransactionList(_transactions)],
    );
  }
}
