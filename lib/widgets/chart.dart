import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterapplesson2/models/Transactions.dart';

import 'chart_bar.dart';

class chart extends StatelessWidget{

  final List<Transactions> recentTransactions;
  chart(this.recentTransactions){print('time : ${recentTransactions.length}');}

  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalAmount=0.0;
      for(var i=0;i<recentTransactions.length;i++)
        {
          if(recentTransactions[i].dateTime.day== weekDay.day &&
              recentTransactions[i].dateTime.month== weekDay.month &&
              recentTransactions[i].dateTime.year== weekDay.year
          ){
            totalAmount += recentTransactions[i].cost;
          }
        }

      print('TIME : ${DateFormat.E().format(weekDay).substring(0,1)}');
      return {'day': DateFormat.E().format(weekDay).substring(0,1),'amount':totalAmount};

    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum,item){
      return sum+item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((tx){
            return Flexible(
              fit: FlexFit.tight,
              child: chart_bar(
                tx['day'],
                tx['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      :
                  (tx['amount'] as double) / totalSpending
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}