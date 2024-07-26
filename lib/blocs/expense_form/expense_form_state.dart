part of 'expense_form_bloc.dart';

enum ExpenseFormStatus {
  initial,
  loading,
  success,
  failure,
}

final class ExpenseFormState extends Equatable {
  const ExpenseFormState({
    this.title,
    this.amount,
    this.date,
    this.category = Category.other,
    this.status = ExpenseFormStatus.initial,
  });

  final String? title;
  final double? amount;
  final DateTime date;
  final Category category;
  final ExpenseFormStatus status;

  @override
  List<Object> get props => [];
}
