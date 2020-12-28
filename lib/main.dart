import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              headline1: TextStyle(fontFamily: 'OpenSans', fontSize: 14)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Shirt',
        amount: 29.99,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Pants',
        amount: 89.99,
        date: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(
      String id, String title, String amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: id, title: title, amount: double.parse(amount), date: date));
    });
  }

  void _deleteTransaction(String id) {
    Transaction index;
    for (Transaction t in _transactions) {
      if (t.id == id) {
        index = t;
      }
    }
    if (index != null) {
      setState(() {
        _transactions.remove(index);
      });
    }
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(title: Text('Personal Expenses'), actions: [
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context))
    ]);

    final transactionList = Container(
      child: TransactionList(_transactions, _deleteTransaction),
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
    );

    final chart = Container(
      child: Chart(_recentTransactions),
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          1,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      })
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            if (!isLandscape)
              Container(
                child: Chart(_recentTransactions),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
              ),
            if (!isLandscape) transactionList,
            if (isLandscape) _showChart ? chart : transactionList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
