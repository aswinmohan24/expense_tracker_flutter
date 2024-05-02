import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uuid/uuid.dart';

getCategoryCreation(BuildContext context) {
  List<String> expenseCategoryIconsList = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

  String isIconSelected = '';

  bool isExpanded = false;

  Category category = Category.empty;
  return showDialog(
      context: context,
      builder: (ctx) {
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: BlocListener<CreateCategoryBloc, CreateCategoryState>(
            listener: (context, state) {
              if (state is CreateCategorySuccess) {
                Navigator.of(ctx).pop(category);
              }
            },
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                  content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Create a Cetegory',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: categoryNameController,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryIconController,
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.expand_more),
                          isDense: true,
                          hintText: 'Icon',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: isExpanded
                                  ? const BorderRadius.vertical(
                                      top: Radius.circular(12))
                                  : BorderRadius.circular(12)),
                        ),
                      ),
                      isExpanded
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(12))),
                              child: GridView.builder(
                                  itemCount: expenseCategoryIconsList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          crossAxisCount: 3),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isIconSelected =
                                                expenseCategoryIconsList[index];
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 3,
                                                color: isIconSelected ==
                                                        expenseCategoryIconsList[
                                                            index]
                                                    ? Colors.blue
                                                    : kGreyColor.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/${expenseCategoryIconsList[index]}.png'))),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: kToolbarHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                              transform: const GradientRotation(pi / 10),
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ]),
                        ),
                        child: TextButton(
                            onPressed: () {
                              //Create category object and pop

                              setState(() {
                                category.categoryId = const Uuid().v1();
                                category.name = categoryNameController.text;
                                category.icon = isIconSelected;
                              });
                              // context.read < CreateCategoryBloc>().add( CreateCategory(category));
                              BlocProvider.of<CreateCategoryBloc>(context)
                                  .add(CreateCategory(category));
                              // Navigator.of(ctx).pop();
                            },
                            child: const Text(
                              'Save',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                ),
              ));
            }),
          ),
        );
      });
}
