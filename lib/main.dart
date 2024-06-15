import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            child: Card(
              child: Text('Grafico'),
            ),
          ),
          Column(
            children: <Widget>[
              ..._transactions.map(
                (tr) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'R\$ ${tr.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.purple),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tr.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(DateFormat('d MMM y').format(tr.date),
                                style: TextStyle(color: Colors.grey[600])),
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'R\$',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          child: const Text(
                            'Nova Transação',
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                          onPressed: () {})
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
