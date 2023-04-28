import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Transaction {
  final String? id;
  final String? tile;
  final double? amount;
  final DateTime? date;

  Transaction(
      {@required this.id,
      @required this.tile,
      @required this.amount,
      @required this.date});
}
