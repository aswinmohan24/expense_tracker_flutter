import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> myTransactionsData = [
  {
    'icons': const FaIcon(
      FontAwesomeIcons.burger,
    ),
    'color': Colors.yellow[700],
    'name': 'Food',
    'totalAmount': '₹ -500.00',
    'date': 'Today'
  },
  {
    'icons': const FaIcon(FontAwesomeIcons.bagShopping),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '₹ -2500.00',
    'date': 'Today'
  },
  {
    'icons': const FaIcon(FontAwesomeIcons.heartCircleCheck),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '₹ -800.00',
    'date': 'Yesterday'
  },
  {
    'icons': const FaIcon(FontAwesomeIcons.plane),
    'color': Colors.blue,
    'name': 'Travel',
    'totalAmount': '₹ -3500.00',
    'date': 'Yesterday'
  }
];
