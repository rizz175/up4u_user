import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class primaryButton extends StatelessWidget {
   primaryButton({
    Key? key,
    required this.title,
    required this.onPress
  }) : super(key: key);

  var onPress;
  var title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 6.4.h,
        width: 100.w,
        child: ElevatedButton(
            onPressed:onPress,
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            )));
  }
}