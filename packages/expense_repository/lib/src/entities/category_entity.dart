class CategoryEntity {
  String categoryId;
  String name;
  int totalExpenses;
  String icon;

  CategoryEntity(
      {required this.categoryId,
      required this.name,
      required this.totalExpenses,
      required this.icon});

  Map<String, Object> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon
    };
  }

  static CategoryEntity fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
        categoryId: json['categoryId'],
        name: json['name'],
        totalExpenses: json['totalExpenses'],
        icon: json['icon']);
  }
}
