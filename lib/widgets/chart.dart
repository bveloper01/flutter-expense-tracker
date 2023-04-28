import 'package:expensetracker/models/transaction.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bars.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTX; // it is all transactions of the last week
  Chart(this.recentTX);
// this recentTx is being used to get the transactions of that day, to fetch the data from the list

  List<Map<String, Object>> get groupedTxValues {
    /*The body might complete normally, causing 'null' to be returned, but the return type, 'List<Map<String, Object>>',
   is a potentially non-nullable type. Try adding either a return or a throw statement at the end.*/
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
        days: index,
      ));
      double totalSumOfTx = 0.0;
      for (var i = 0; i < recentTX.length; i++) {
        // we go through all the elements of recent transactions and iterate them
        if (recentTX[i].date!.day == weekDay.day &&
            recentTX[i].date!.month == weekDay.month &&
            recentTX[i].date!.year == weekDay.year) {
          totalSumOfTx += recentTX[i].amount!;
        } /* this loop here tells that are we looking at a transaction that happened on the weekDay when considering
            for the iteration in our list generation*/

      }
      return {
        'Day': DateFormat('EEEE', 'en_US').format(weekDay),
        'amount': totalSumOfTx,
      };
    });
  }

  double get totalSpending {
    // this function gives us the total sum of the entire week
    return groupedTxValues.fold(0.0, (sum, item) {
      //here sum is the total amount and item is element we are looking at
      return sum +
          (item['amount']
              as double); // this will give all the totals for each day also here we telling dart that this value here will be of type double
    }); // here sum and element are being passed
  } //0.0 is the starting value

  @override
  Widget build(BuildContext context) {
    print(groupedTxValues);
    return Container(
      height: 155,
      //do not change card to const constructor
      padding: EdgeInsets.fromLTRB(9, 7, 9, 0), //left, top, right, bottom
      // color: Color.fromARGB(255, 251, 251,212), //arguments like color should be defined outside of the SizedBOx
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: groupedTxValues.map((txData) {
            /*Flexible and Expanded(
            flex: 1,
            fit: FlexFit.tight,), - fit to flexfit type in Expanded widget 
Flexible widget allows to set constraints to the column or row and space aroung it*/
            return chartBartx(
                (txData['Day'] as String),
                (txData['amount'] as double),
                totalSpending == 0.0
                    ? 0.0
                    : (txData['amount'] as double) / totalSpending);
          }).toList(),
        ),
      ),
    );
  }
}
