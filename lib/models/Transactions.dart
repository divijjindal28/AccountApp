import 'package:flutter/foundation.dart';


class Transactions{
  final String id;
  final String item;
  final double cost;
  final DateTime dateTime;


  Transactions({
    @required this.id,
    @required this.item,
    @required this.cost,
    @required this.dateTime

  });
}