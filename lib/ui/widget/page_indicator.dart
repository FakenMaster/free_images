import 'package:flutter/widgets.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int selectedIndex;

  PageIndicator({this.count, this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++)
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color:
                    i != selectedIndex ? Color(0xffbdc3c7) : Color(0xffffffff),
                borderRadius: BorderRadius.circular(2)),
          )
      ],
    );
  }
}
