import 'package:app_despesas_pessoais/components/transaction_form.dart';
import './components/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'dart:math';
import './components/chart.dart';

void main() {
  runApp(const ExpensesAppp());
}

class ExpensesAppp extends StatelessWidget {
  const ExpensesAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                color: Colors.white,
                /* fontWeight: FontWeight.bold, */
                fontFamily: 'OpenSans')),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.purple,
          secondary: Colors.purple,
          onPrimary: Colors.amber,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: '1', title: 'cachorro', value: 45, date: DateTime.now())
  ];

  List<Transaction> get _recenteTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });
    //? Função que fecha o modal após add a transação
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20 * MediaQuery.textScalerOf(context).scale(1)),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      actions: <Widget>[
        IconButton(
          color: Theme.of(context).colorScheme.background,
          icon: const Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        )
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: availableHeight * 0.23,
                child: Chart(recentTransaction: _recenteTransactions)),
            SizedBox(
              height: availableHeight * 0.77,
              child: TransactionList(
                  transactions: _transactions, onRemove: _removeTransaction),
            )
          ],
        ),
      ),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () => _openTransactionFormModal(context),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
