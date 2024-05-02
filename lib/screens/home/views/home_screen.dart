import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_expense_bloc/get_expense_bloc.dart';

import 'package:expense_tracker/screens/add_expense/views/add_expense.dart';
import 'package:expense_tracker/screens/home/views/main_screen.dart';
import 'package:expense_tracker/screens/home/views/widgets/bottom_nav.dart';

import 'package:expense_tracker/screens/stats/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final ValueNotifier<int> bottomNavIndexNotifier = ValueNotifier(0);

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final pageList = [const MainScreen(), const StatsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: bottomNavIndexNotifier,
          builder: (context, index, _) {
            return pageList[index];
          }),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: StatefulBuilder(builder: (context, setState) {
        return BlocBuilder<GetExpenseBloc, GetExpenseState>(
          builder: (context, state) {
            if (state is GetExpenseSuccess) {
              return FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () async {
                  var newExpense = await Navigator.of(context)
                      .push(MaterialPageRoute<Expense>(builder: (ctx) {
                    return MultiBlocProvider(providers: [
                      BlocProvider(
                          create: (context) =>
                              CreateCategoryBloc(FirebaseExpenseRepo())),
                      BlocProvider(
                          create: (context) =>
                              GetCategoryBloc(FirebaseExpenseRepo())
                                ..add(GetCategories())),
                      BlocProvider(
                          create: (context) =>
                              CreateExpenseBloc(FirebaseExpenseRepo())),
                    ], child: const AddExpenseScreen());
                  }));

                  if (newExpense != null) {
                    setState(() {
                      state.expense.insert(0, newExpense);
                    });
                  }
                },
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            transform: const GradientRotation(pi / 4),
                            colors: [
                              Colors.deepPurple,
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                              //  Theme.of(context).colorScheme.tertiary,
                            ])),
                    child: const Icon(CupertinoIcons.add)),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
