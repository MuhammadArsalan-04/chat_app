// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  const CustomText({
    Key? key,
    required this.text,
    this.color,
    this.size,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: color == null
          ? Theme.of(context).textTheme.bodyLarge
          : Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
