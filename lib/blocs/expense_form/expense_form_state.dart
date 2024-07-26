part of 'expense_form_bloc.dart';

enum ExpenseFormStatus {
  initial,
  loading,
  success,
  failure,
}

final class ExpenseFormState extends Equatable {
  const ExpenseFormState({});
  final String? title;
  final double? amount;
  final DateTime date;
  final Category category;
  final ExpenseFormStatus status;

  @override
  List<Object> get props => [];
}
