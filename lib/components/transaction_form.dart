import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickdDate) {
      if (pickdDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickdDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              onChanged: (value) => value = value,
              decoration: const InputDecoration(
                labelText: 'R\$',
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Text(_selectedDate == null
                      ? 'Nenhuma data selecionada'
                      : DateFormat('d/M/y').format(_selectedDate!)),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _submitForm,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple)),
                    child: const Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
