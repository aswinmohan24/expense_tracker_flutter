import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitCircle(
      color: color,
      size: 50,
    ));
  }
}
