import './widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/new_tx.dart';
import './widgets/list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData.dark(
/*The latest version of Flutter, some theme identifiers changed:-
display4 => headline1;
display3 => headline2;
display2 => headline3;
display1 => headline4;
headline => headline5;
title    => headline6; 
subhead  => subtitle1;
subtitle => subtitle2;
body2    => bodyText1; 
body     => bodyText2; 

In case the textTheme doesn't work on the appBarTheme, change the code from-
appBarTheme: AppBarTheme(
  textTheme: ThemeData.light().textTheme.copyWith(...)
)
              to

appBarTheme: AppBarTheme(
  titleTextStyle: TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.bold
  )
)

        textTheme: ThemeData.dark().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ), // - this here is defining the texttheme globally to all the title texts in the app*/
          //fontFamily: 'Quicksand',
          /* appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
                   - this here is defining the appbartheme globally */
          ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String? titleInput;
  final List<Transaction> _usertxs = [
    /* Transaction(id: 't1', tile: 'Book', amount: 298.56, date: DateTime.now()),
    Transaction(id: 't2', tile: 'Shoe', amount: 3499, date: DateTime.now())*/
  ];
  // get is dynamically calculated property
  List<Transaction> get _recentTX {
    // here we are using recentTX cause we only want the transactions
    return _usertxs.where((tx) {
      // that happend in the last week not all of them
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(
              days:
                  7), // only transactions that are younger or less than 7 days are included here
        ),
      );
    }).toList();
  }
/*The above solution works, this is because the get _recentTransactions expects a returned value of Type List .
But _userTransactions.where() returns object of type Iterable<Transaction> .
This is why we need to add .toList() which would convert Iterable<Transaction> type to List<Transaction> */

  void _addnewTxs(String txtitle, double txamount, DateTime chosenDate) {
    final newT = Transaction(
        id: DateTime.now().toString(),
        tile: txtitle,
        amount: txamount,
        date: chosenDate);
    setState(() {
      _usertxs.add(newT);
    });
  }

  void _startAddNewTx(BuildContext rengokutx) {
    showModalBottomSheet(
      //backgroundColor: Color(0xff393F44),
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      //showModalBottomSheet is available in staterfulwidget
      context: rengokutx,
      builder: (_) {
        return newTransaction(_addnewTxs);
      },
    );
  }

  void onDismissed(String id) {
    setState(() {
      _usertxs.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18))),
        backgroundColor: Color(0xff393F44),
        centerTitle: true,
        title: const Text('Expense Tracker',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTx(context), icon: Icon(Icons.add))
        ],
      ), //_startAddNewTx required build context to show newmodalsheet
      // and here we are calling it as an anonymus function to call it manually and
      //forward context value here
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentTX), //dynamically generated property - _recentTX
            txList(
                _usertxs, onDismissed), //here we passed _usertxs list into txList function
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 255, 221, 83),
        onPressed: () => _startAddNewTx(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
