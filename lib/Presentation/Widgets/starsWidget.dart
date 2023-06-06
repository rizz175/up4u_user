import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final int value;

  StarDisplay({required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(right:4),
          child: Icon(
            index < value ? CupertinoIcons.star_fill : CupertinoIcons.star_fill,color: index < value ?Colors.amber:Colors.black12,
          ),
        );
      }),
    );
  }
}