
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapplesson2/widgets/TransactionList.dart';
import 'package:flutterapplesson2/widgets/TransactionListInput.dart';
import 'package:flutterapplesson2/widgets/chart.dart';

import 'models/Transactions.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations(
//        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 15),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)))),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: MyAppHome());
  }
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> with WidgetsBindingObserver  {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    print(state);
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,

        builder: (ctx) {
          return TransactionListInput(_addTransaction);
        });
  }

  final List<Transactions> _transactions = [
    Transactions(id: '1', item: 'Shoes', cost: 78.99, dateTime: DateTime.now()),
    Transactions(
        id: '2', item: 'Clothes', cost: 58.99, dateTime: DateTime.now()),
  ];



  bool _showChart=true;

  void _addTransaction(String name, double cost, DateTime date) {
    Transactions newTansaction = Transactions(
        id: DateTime.now().toString(), item: name, cost: cost, dateTime: date);
    setState(() {
      print('Date ; ' + DateTime.now().toString());
      _transactions.add(newTansaction);
    });
  }

  List<Transactions> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  void _deleteTransaction(BuildContext context, String id) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure you want to delete the transaction?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  _transactions.removeWhere((tx) => tx.id == id);
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  List<Widget> _buildLandscapeMode(MediaQueryData mediaQuery, AppBar appBar, Widget transactionList){
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Text('Show Chart'),
          Switch(
            value: _showChart,
            onChanged: (val){
              setState(() {
                _showChart=val;
              });

            },
          )
        ],),
      _showChart? Container(
          height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              0.75,
          child: chart(_recentTransactions))
          : transactionList
    ];

  }

  List<Widget> _buildPortraitMode(MediaQueryData mediaQuery, AppBar appBar, Widget transactionList){
    return [
      Container(
          height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              0.25,
          child: chart(_recentTransactions)),transactionList
    ];

  }


  @override
  Widget build(BuildContext context) {

    final mediaQuery= MediaQuery.of(context);

    bool isLandscape=mediaQuery.orientation == Orientation.landscape;



    var appBar = AppBar(
      actions: <Widget>[
        Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () => startAddNewTransaction(context)),
        )
      ],
      title: Center(child: Text("Hissab")),
    );

    final transactionList = Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.75,
        child: TransactionList(_transactions, _deleteTransaction));

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          ),
        ),
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              if(isLandscape) ..._buildLandscapeMode(mediaQuery, appBar, transactionList),


              if(!isLandscape) ..._buildPortraitMode(mediaQuery, appBar, transactionList)
            ],
          ),
        ));
  }
}
