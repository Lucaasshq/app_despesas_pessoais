import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensesAppp());
}

class ExpensesAppp extends StatelessWidget {
  const ExpensesAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            child: Card(
              child: Text('Grafico'),
            ),
          ),
          Column(children: <Widget>[
            ..._transactions.map((tr) {
              return Card(
                child: Text(tr.title),
              );
            })
          ])
        ],
      ),
    );
  }
}
