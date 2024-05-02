import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_category_bloc/get_category_bloc.dart';

import 'package:expense_tracker/screens/add_expense/views/widgets/alert_dialog.dart';
import 'package:expense_tracker/screens/home/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late Expense expense;

  bool isLoading = false;
  bool isCategorySelected = false;
  bool isExpanded = true;
  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseid = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategorySuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Add Expense',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            controller: expenseController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                FontAwesomeIcons.indianRupeeSign,
                                size: 20,
                                color: kGreyColor,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: categoryController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: isCategorySelected
                                  ? expense.category.name
                                  : 'Category',
                              prefixIcon: isCategorySelected
                                  ? Image.asset(
                                      'assets/${expense.category.icon}.png',
                                      scale: 2,
                                    )
                                  : const Icon(
                                      FontAwesomeIcons.list,
                                      size: 20,
                                      color: kGreyColor,
                                    ),
                              suffixIcon: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.expand_more,
                                        color: kGreyColor,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        final newCategories =
                                            await getCategoryCreation(context);

                                        setState(() {
                                          state.categories
                                              .insert(0, newCategories);
                                        });
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.plus,
                                        color: kGreyColor,
                                        size: 20,
                                      )),
                                ],
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: isExpanded
                                      ? const BorderRadius.vertical(
                                          top: Radius.circular(30))
                                      : const BorderRadius.all(
                                          Radius.circular(30)))),
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: MediaQuery.of(context).size.width,
                            height: isExpanded ? 200 : 0,
                            decoration: const BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12))),
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: state.categories.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        expense.category =
                                            state.categories[index];
                                        isCategorySelected = true;
                                        isExpanded = !isExpanded;
                                        categoryController.text =
                                            expense.category.name;
                                      });
                                    },
                                    leading: Image.asset(
                                      'assets/${state.categories[index].icon}.png',
                                      scale: 2,
                                    ),
                                    title: Text(state.categories[index].name),
                                    // tileColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ));
                                })),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: dateController,
                          onTap: () async {
                            final newDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 30)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)));
                            if (newDate != null) {
                              setState(() {
                                dateController.text =
                                    DateFormat('dd/MM/yyyy').format(newDate);
                                expense.date = newDate;
                              });
                            }
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Date',
                            prefixIcon: Icon(
                              FontAwesomeIcons.clock,
                              size: 20,
                              color: kGreyColor,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        isLoading
                            ? const SizedBox(
                                width: double.infinity,
                                height: kToolbarHeight,
                                child: Center(
                                    child: LoadingWidget(color: Colors.blue)),
                              )
                            : Container(
                                width: double.infinity,
                                height: kToolbarHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      transform:
                                          const GradientRotation(pi / 10),
                                      colors: [
                                        //  Colors.deepPurple,
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.secondary,
                                      ]),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        expense.amount = double.parse(
                                            expenseController.text);
                                      });

                                      BlocProvider.of<CreateExpenseBloc>(
                                              context)
                                          .add(CreateExpense(expense));
                                      // BlocProvider.of<CreateExpenseBloc>(
                                      //         context)
                                      //     .add(CreateExpense(expense));
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                          color: kWhiteColor, fontSize: 20),
                                    ))),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                    child: LoadingWidget(
                  color: Colors.blue,
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
