import 'package:flutter/material.dart';

class YearChart extends StatelessWidget {
  const YearChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        'https://picsum.photos/250?image=9',
      ),
    );
  }
}
