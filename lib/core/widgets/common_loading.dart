
import 'package:flutter/material.dart';

class CommonLoading extends StatelessWidget {
  final double? height;
  const CommonLoading({this.height,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.4,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );;
  }
}
