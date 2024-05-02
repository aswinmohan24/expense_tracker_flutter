import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_expense_bloc/get_expense_bloc.dart';
import 'package:expense_tracker/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
          // fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              //0xFF00B2E7
              primary: Colors.blueAccent,
              secondary: const Color(0XFFE067F7),
              tertiary: const Color(0XFFFF8D6C),
              outline: Colors.grey)),
      home: BlocProvider(
        create: (context) =>
            GetExpenseBloc(FirebaseExpenseRepo())..add(GetExpense()),
        child: HomeScreen(),
      ),
    );
  }
}
