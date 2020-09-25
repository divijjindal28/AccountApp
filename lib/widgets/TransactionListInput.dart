import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListInput extends StatefulWidget {
  final Function addTransaction;
  TransactionListInput(this.addTransaction);

  @override
  _TransactionListInputState createState() => _TransactionListInputState();
}

class _TransactionListInputState extends State<TransactionListInput> {
  final itemController = TextEditingController();
  final costController = TextEditingController();
  DateTime _selectedDate;

  void _selecteNewDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((datePicked) {
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  void buttonPressed() {
    if (itemController.text.isEmpty ||
        double.parse(costController.text) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.addTransaction(
        itemController.text, double.parse(costController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 18,
              right: 18,
              top: 18,
              bottom: MediaQuery.of(context).viewInsets.bottom + 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onSubmitted: (_) => buttonPressed,
                  controller: itemController,
                  decoration: InputDecoration(
                      hintText: 'Item',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  onSubmitted: (_) => buttonPressed,
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Cost',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      )),
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text((_selectedDate == null)
                          ? ("No Date Selected")
                          : ("Selected Date : ${DateFormat.yMMMMd().format(_selectedDate)}")),
                    ),
                    FlatButton(
                      onPressed: _selecteNewDate,
                      child: Text(
                        "Select Date",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Add Transaction",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: buttonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
