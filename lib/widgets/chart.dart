import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumDay = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSumDay += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSumDay,
      };
    });
  }

  double get maxSpending {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / (maxSpending)));
          }).toList(),
        ),
      ),
    );
  }
}
