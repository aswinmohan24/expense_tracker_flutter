import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_expense_bloc/get_expense_bloc.dart';
import 'package:expense_tracker/screens/home/views/widgets/loading_widget.dart';
import 'package:expense_tracker/screens/stats/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  Color? getColor(int index) {
    // Calculate the index of the color to use
    int colorIndex = index % iconBackgroundColor.length;
    return iconBackgroundColor[colorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: kWhiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.receipt,
                    color: kGreyColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Transactions',
                  style: TextStyle(
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              child: const Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '01 Apr 2024 - 30 Apr 2024',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('₹ 38545.00',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 100,
                decoration: const BoxDecoration(
                    color: kWhiteColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12))),
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: const MyChart()),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: AnimationLimiter(
                child: BlocBuilder<GetExpenseBloc, GetExpenseState>(
                  builder: (context, state) {
                    if (state is GetExpenseSuccess) {
                      return ListView.builder(
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
                                            Text(
                                              '₹ ${state.expense[index].amount}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const LoadingWidget(color: Colors.blue);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
