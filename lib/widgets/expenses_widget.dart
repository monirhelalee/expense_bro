import 'package:expense_bro/blocs/expense_list/expense_list_bloc.dart';
import 'package:expense_bro/widgets/expense_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListBloc, ExpenseListState>(
      builder: (context, state) {
        if (state.status == ExpenseListStatus.loading) {
          return const SizedBox(
            height: 12,
            width: 12,
            child: CircularProgressIndicator(),
          );
        }

        final expenses = state.filteredExpenses.toList();

        if (state.status == ExpenseListStatus.success && expenses.isEmpty) {
          return const Center(
            child: Text('No data found'),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) => ExpenseTileWidget(
            expense: expenses[index]!,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: expenses.length,
        );
      },
    );
  }
}
