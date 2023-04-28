//this widget is holding the text fields
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  /*here we changed statelesswidget to a 
statefulwidget to keep the state changes */

  final Function atx;

  newTransaction(this.atx);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime? selectedDate;

  void submitData() {
    if (amountcontroller.text.isEmpty) {
      return;
    }
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      //'<=' this means below zero or equal zero
      return;
    }
    widget.atx(
      //with widget.atx we can access the properties and methods of
      //main widget class inside of your state class even though we are in a
      // different class
      enteredTitle, // titleController.text,
      enteredAmount,
      selectedDate, //double.parse(amountController.text),
    );
    Navigator.of(context)
        .pop(); //this fuction closes the modalsheet by popping it off and
    //context here gives access to the context related to your widget
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2008),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 255, 221, 83), // <-- SEE HERE
              onPrimary: Colors.black, // <-- SEE HERE
              onSurface: Colors.white, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      //adding custom date to the transactions
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    }); //furture can also be used in http requests where you wait for response from the user
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(9, 19, 9, 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
            cursorColor: Color.fromARGB(255, 255, 221, 83),
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.white, fontSize: 15.8),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(23),
                borderSide: BorderSide(color: Colors.white, width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(23),
                borderSide: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            controller: titlecontroller,
            onSubmitted: (_) =>
                submitData(), //manually triggering our function by calling the function with '()'
            style: TextStyle(
              fontSize: 17,
            )),
        const SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Container(
              width: 328.3,
              child: TextField(
                  cursorColor: Color.fromARGB(255, 255, 221, 83),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 15.8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                  ),
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      submitData(), //manually triggering our function by calling the function with '()'
                  style: TextStyle(
                    fontSize: 17,
                  )),
            ),
            SizedBox(width: 8.5),
            FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 255, 221, 83),
              elevation: 1.9,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              foregroundColor: Colors.black,
              onPressed: presentDatePicker,
              child: Icon(Icons.date_range_outlined),
            ),
          ],
        ),
        SizedBox(
          height: 11,
        ),
        Container(
          padding: EdgeInsets.only(left: 5.2),
          alignment: Alignment.centerLeft,
          child: Text(
              style: const TextStyle(fontSize: 15, color: Colors.white),
              selectedDate == null
                  ? 'No Date Chosen!'
                  : DateFormat('EEEE, dd/MM/yyyy').format(selectedDate!)),
        ),
        SizedBox(
          height: 24,
        ),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              primary: Color.fromARGB(255, 255, 221, 83),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(97, 12, 97, 12),
              child: Text(
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  "Add Transaction"),
            ),
            onPressed: submitData,
          ),
        ),
      ]),
    );
  }
}