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
}
