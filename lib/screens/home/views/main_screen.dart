import 'dart:math';

import 'package:expense_tracker/core/constants/colors.dart';

import 'package:expense_tracker/screens/add_expense/blocs/get_expense_bloc/get_expense_bloc.dart';
import 'package:expense_tracker/screens/home/views/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animate_do/animate_do.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Color? getColor(int index) {
    // Calculate the index of the color to use
    int colorIndex = index % iconBackgroundColor.length;
    return iconBackgroundColor[colorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpenseBloc, GetExpenseState>(
      builder: (context, state) {
        if (state is GetExpenseSuccess) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.yellow[700]),
                        child: const Icon(CupertinoIcons.person_fill),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey),
                          ),
                          Text(
                            'Aswin Vm',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_suggest_rounded))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SlideInLeft(
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(5, 5))
                          ],
                          gradient: LinearGradient(
                              transform: const GradientRotation(pi / 4),
                              colors: [
                                Colors.deepPurple,
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,

                                //  Theme.of(context).colorScheme.tertiary,
                              ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '₹ 38545.00',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 12),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  child: Icon(
                                    size: 15,
                                    CupertinoIcons.arrow_down,
                                    color: Colors.yellow,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '₹ 15350.00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 13,
                                  child: Icon(
                                    size: 15,
                                    CupertinoIcons.arrow_up,
                                    color: Colors.yellow,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '₹ 18400.00',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                          itemCount: state.expense.length,
                          itemBuilder: (context, index) {
                            Color? backgroundColor = getColor(index);
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                verticalOffset: 50,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Container(
                                      // width: double.infinity,
                                      // height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor: backgroundColor,
                                              child: Image.asset(
                                                'assets/${state.expense[index].category.icon}.png',
                                                scale: 2,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              state
                                                  .expense[index].category.name,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '₹ ${state.expense[index].amount}',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onBackground,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  DateFormat('dd/MM/yy').format(
                                                      state
                                                          .expense[index].date),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
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
    );
  }
}
