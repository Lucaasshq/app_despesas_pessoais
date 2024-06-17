import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
  });
  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 490,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tr = transactions[index];
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
          }),
    );
  }
}
