import 'package:expense_bro/blocs/expense_form/expense_form_bloc.dart';
import 'package:expense_bro/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensesSheetWidget extends StatelessWidget {
  const AddExpensesSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TitleFieldWidget(),
            const SizedBox(
              height: 16,
            ),
            const AmountFieldWidget(),
            const SizedBox(
              height: 16,
            ),
            const DateFieldWidget(),
            const SizedBox(
              height: 24,
            ),
            CategoryChoicesWidget(),
            const SizedBox(
              height: 30,
            ),
            AddButtonWidget(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExpenseFormBloc>().state;
    final isLoading = state.status == ExpenseFormStatus.loading;

    return FilledButton(
      onPressed: isLoading || !state.isFormValid
          ? null
          : () {
              context.read<ExpenseFormBloc>().add(const ExpenseSubmitted());
              Navigator.pop(context);
            },
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text('Add Expense'),
    );
  }
}

class CategoryChoicesWidget extends StatelessWidget {
  const CategoryChoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final bloc = context.read<ExpenseFormBloc>();
    final state = context.watch<ExpenseFormBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select Category',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.4),
            height: 1,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 0,
          children: Category.values
              .where((category) => category != Category.all)
              .map((currentCategory) => ChoiceChip(
                    label: Text(currentCategory.toName),
                    selected: currentCategory == state.category,
                    onSelected: (_) {
                      ExpenseCategoryChanged(currentCategory);
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class DateFieldWidget extends StatelessWidget {
  const DateFieldWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final bloc = context.read<ExpenseFormBloc>();
    final state = context.watch<ExpenseFormBloc>().state;

    final formattedDate = DateFormat('dd/MM/yyyy').format(state.date);

    return GestureDetector(
      onTap: () async {
        final today = DateTime.now();
        final selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(today.year + 50),
        );

        if (selectedDate != null) {
          bloc.add(ExpenseDateChanged(selectedDate));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Date',
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.4),
              height: 1,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            formattedDate,
            style: textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}

class TitleFieldWidget extends StatelessWidget {
  const TitleFieldWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ExpenseFormBloc>().state;

    return TextFormField(
      style: textTheme.displaySmall?.copyWith(fontSize: 30),
      onChanged: (value) {
        context.read<ExpenseFormBloc>().add(ExpenseTitleChanged(value));
      },
      decoration: InputDecoration(
        enabled: state.status != ExpenseFormStatus.loading,
        border: InputBorder.none,
        hintText: 'Expense Title',
      ),
    );
  }
}

class AmountFieldWidget extends StatelessWidget {
  const AmountFieldWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ExpenseFormBloc>().state;

    return TextFormField(
      style: textTheme.displaySmall?.copyWith(fontSize: 30),
      onChanged: (value) {
        context.read<ExpenseFormBloc>().add(ExpenseAmountChanged(value));
      },
      decoration: InputDecoration(
        enabled: state.status != ExpenseFormStatus.loading,
        border: InputBorder.none,
        label: const Text('Amount'),
        prefixText: '\$',
        hintText: '0.00',
      ),
    );
  }
}
