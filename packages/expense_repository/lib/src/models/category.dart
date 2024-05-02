import 'package:expense_repository/src/entities/category_entity.dart';

class Category {
  String categoryId;
  String name;
  int totalExpenses;
  String icon;

  Category(
      {required this.categoryId,
      required this.name,
      required this.totalExpenses,
      required this.icon});

  static Category empty =
      Category(categoryId: '', name: '', totalExpenses: 0, icon: '');

  CategoryEntity toEntity() {
    return CategoryEntity(
        categoryId: categoryId,
        name: name,
        totalExpenses: totalExpenses,
        icon: icon);
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
        categoryId: entity.categoryId,
        name: entity.name,
        totalExpenses: entity.totalExpenses,
        icon: entity.icon);
  }
}
