import 'package:expense_bro/models/expense.dart';

enum Category {
  all,
  grocery,
  food,
  work,
  transport,
  entertainment,
  traveling,
  other;

  String toJson() => name;
  static Category fromJson(String json) => values.byName(json);
}

extension CategoryX on Category {
  String get toName => switch (this) {
        Category.all => 'All',
        Category.grocery => 'Grocery',
        Category.food => 'Food',
        Category.work => 'Work',
        Category.transport => 'Transport',
        Category.entertainment => 'Entertainment',
        Category.traveling => 'Traveling',
        Category.other => 'Other',
      };
  bool apply(Expense? expense) => switch (this) {
        Category.all => true,
        Category.grocery => expense?.category == Category.grocery,
        Category.food => expense?.category == Category.food,
        Category.work => expense?.category == Category.work,
        Category.transport => expense?.category == Category.transport,
        Category.entertainment => expense?.category == Category.entertainment,
        Category.traveling => expense?.category == Category.traveling,
        Category.other => expense?.category == Category.other,
      };

  Iterable<Expense?> applyAll(Iterable<Expense?> expenses) {
    return expenses.where(apply);
  }
}
