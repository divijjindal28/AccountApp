

import 'package:flutter/material.dart';

class chart_bar extends StatelessWidget{

  final String label;
  final double amount;
  final double amountPerCent;

  chart_bar(this.label,this.amount,this.amountPerCent);
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return LayoutBuilder(

        builder : (ctx,constraints){
      return Column(children: <Widget>[
        Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text('\$ ${amount.toStringAsFixed(0)}'))),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),

        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(color: Colors.grey,width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),

              ),
              FractionallySizedBox(heightFactor: amountPerCent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),

                )
              )
            ],
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05,),
        Container(
          height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)))

      ],);
    });
  }

}