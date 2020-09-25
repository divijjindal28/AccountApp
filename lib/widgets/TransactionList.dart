import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transactions.dart';
import 'TransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "No transactions here",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 200, 
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(transactions[index],deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
