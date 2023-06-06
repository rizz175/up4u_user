import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        height: 100,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [Color(0xfff5a623)],
          strokeWidth: 3,
        ));
  }
}