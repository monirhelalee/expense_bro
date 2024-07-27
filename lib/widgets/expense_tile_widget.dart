import 'package:expense_bro/blocs/expense_list/expense_list_bloc.dart';
import 'package:expense_bro/extensions/extensions.dart';
import 'package:expense_bro/models/expense.dart';
import 'package:expense_bro/utils/formate_total_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseTileWidget extends StatelessWidget {
  const ExpenseTileWidget({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final formattedDate = DateFormat('dd/MM/yyyy').format(expense.date);

    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        color: colorScheme.error,
        child: Icon(
          Icons.delete,
          color: colorScheme.onError,
        ),
      ),
      onDismissed: (direction) {
        context.read<ExpenseListBloc>().add(
              ExpenseListExpenseDeleted(expense: expense),
            );
      },
      child: ListTile(
        onTap: () => context.showAddExpenseSheet(expense: expense),
        leading: Icon(Icons.work, color: colorScheme.surfaceTint),
        title: Text(
          expense.title,
          style: textTheme.titleMedium,
        ),
        subtitle: Text(
          formattedDate,
          style: textTheme.bodySmall
              ?.copyWith(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        trailing: Text(
          formatTotalExpenses(expense.amount),
          style: textTheme.titleLarge,
        ),
      ),
    );
  }
}
