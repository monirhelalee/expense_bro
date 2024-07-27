import 'package:expense_bro/extensions/extensions.dart';
import 'package:expense_bro/widgets/expenses_widget.dart';
import 'package:expense_bro/widgets/total_expenses_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Good Morning'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TotalExpensesWidget(),
            SizedBox(
              height: 14,
            ),
            //ExpenseFilterWidget(),
            SizedBox(
              height: 14,
            ),
            ExpensesWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.showAddExpenseSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
