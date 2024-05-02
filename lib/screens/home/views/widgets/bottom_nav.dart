import 'package:expense_tracker/screens/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ValueListenableBuilder(
          valueListenable: bottomNavIndexNotifier,
          builder: (context, newIndex, _) {
            return BottomNavigationBar(
                currentIndex: newIndex,
                onTap: (value) {
                  bottomNavIndexNotifier.value = value;
                },
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Theme.of(context).colorScheme.outline,
                elevation: 3,
                items: const [
                  BottomNavigationBarItem(
                      tooltip: 'Home',
                      icon: Icon(CupertinoIcons.home),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      tooltip: 'Stats',
                      icon: Icon(CupertinoIcons.graph_square_fill),
                      label: 'Stats')
                ]);
          }),
    );
  }
}
