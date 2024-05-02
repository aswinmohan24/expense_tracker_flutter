import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class ExpenseEntity {
  String expenseid;
  Category category;
  DateTime date;
  double amount;

  ExpenseEntity(
      {required this.expenseid,
      required this.category,
      required this.date,
      required this.amount});

  Map<String, Object> toJson() {
    return {
      'expenseid': expenseid,
      'category': category.toEntity().toJson(),
      'date': date,
      'amount': amount
    };
  }

  static ExpenseEntity fromJson(Map<String, dynamic> json) {
    return ExpenseEntity(
        expenseid: json['expenseid'],
        category:
            Category.fromEntity(CategoryEntity.fromJson(json['category'])),
        date: (json['date'] as Timestamp).toDate(),
        amount: json['amount']);
  }
}
