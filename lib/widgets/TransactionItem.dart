import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutterapplesson2/models/Transactions.dart';

class TransactionItem extends StatelessWidget{

  final Transactions transaction;
  final Function deleteTransaction;

  TransactionItem(this.transaction,this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                  "\$" + transaction.cost.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            transaction.item,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMMd().format(transaction.dateTime),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
              onPressed: () {
                deleteTransaction(context, transaction.id);
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              label: Text('Delete',
                style: Theme.of(context).textTheme.title,
              ))
              : IconButton(
            onPressed: () {
              deleteTransaction(context, transaction.id);
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
          ),
        ));
  }
}