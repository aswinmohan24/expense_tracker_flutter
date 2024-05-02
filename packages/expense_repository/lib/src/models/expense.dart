import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseid;
  Category category;
  DateTime date;
  double amount;

  Expense(
      {required this.expenseid,
      required this.category,
      required this.date,
      required this.amount});

  static Expense empty = Expense(
      expenseid: '', category: Category.empty, date: DateTime.now(), amount: 0);

  ExpenseEntity toEntity() {
    return ExpenseEntity(
        expenseid: expenseid, category: category, date: date, amount: amount);
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
        expenseid: entity.expenseid,
        category: entity.category,
        date: entity.date,
        amount: entity.amount);
  }
}
