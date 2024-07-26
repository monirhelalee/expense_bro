import 'package:expense_bro/blocs/expense_form/expense_form_bloc.dart';
import 'package:expense_bro/repositories/expense_repository.dart';
import 'package:expense_bro/widgets/add_expenses_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension AppX on BuildContext {
  Future<void> showAddExpenseSheet() {
    return showModalBottomSheet(
      context: this,
      builder: (context) => BlocProvider(
        create: (context) => ExpenseFormBloc(
          repository: read<ExpenseRepository>(),
        ),
        child: const AddExpensesSheetWidget(),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
    );
  }
}
