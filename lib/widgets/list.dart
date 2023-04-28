import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class txList extends StatelessWidget {
  final List<Transaction> expenses;
  final Function deleteTx;
  txList(this.expenses, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.4, 8, 8.4, 8),
      // color: Color.fromARGB(255, 251, 251, 212),
      height: 640.8,
      child: expenses.isEmpty
          ? Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Text(
                    'Add Transactions',
                    style: Theme.of(context).textTheme.headline6,
                  ),*/
                Image.asset(
                  'images/add_img.png',
                  height: 350,
                  width: 365,
                  /*fit: BoxFit
                          .cover*/
                ), // and you have to add this image to pubspec.yaml file as well
              ],
            )
          : ListView.builder(
              itemBuilder: ((ctx, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                        extentRatio: 0.27,
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            deleteTx(expenses[index].id);
                          },
                        ),
                        children: [
                          SlidableAction(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            onPressed: (context) =>
                                (deleteTx(expenses[index].id)),
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                    child: Card(
                      color: Color(0xff393F44),
                      elevation: 8,
                      shadowColor: Colors.black,
                      /* another widget can be used here- return ListTile(leading: CircleAvator(radius :30, child: Text:'xyz'),),
                            This can be used to add a circular shape just like a circluar card*/
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Container(
                          width: 70,
                          height: 59,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 194,
                                height: 25,
                                child: FittedBox(
                                  child: Text(
                                    expenses[index].tile!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 212, 212, 212)),
                                DateFormat.yMMMMEEEEd()
                                    .format(expenses[index].date!),
                                /*
                                                     DateFormat('dd-MM-yyyy').format(tx.date!);
                                                     DateFormat.yMMMMEEEEd().format(tx.date);
                                                     ==> 'Wednesday, January 10, 2012'
                                                     DateFormat('EEEEE', 'en_US').format(aDateTime);
                                                     ==> 'Wednesday'
                                          
                                                     You can also parse dates using the same skeletons or patterns.
                                                     DateFormat.yMd('en_US').parse('1/10/2012');
                                                     Skeletons can be combined, the main use being to print a full date and time, e.g.
                                          
                                                     DateFormat.yMEd().add_jms().format(DateTime.now());
                                                     ==> 'Thu, 5/23/2013 10:21:47 AM'  */
                              ),
                            ],
                          ),
                        ),

                        trailing:
                            /* decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black, width: 1.65),
                                           ),
                                          padding: EdgeInsets.all(5),*/

                            Container(
                          alignment: Alignment.centerRight,
                          width: 157,
                          height: 90,
                          child: FittedBox(
                            child: Text(
                                style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Color.fromARGB(255, 255, 221, 83),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.5,
                                ),
                                '₹${expenses[index].amount!.toStringAsFixed(2)} '),
                          ),
                        ),

                        //String interpolation method used,
                      ),
                    ),
                  ),
                );
              }),
              itemCount:
                  expenses.length, //renders to the length of the expenses list
            ),
    );
  }
}
