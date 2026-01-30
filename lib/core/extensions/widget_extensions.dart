import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget paddingHorizontal(double value) => Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);
  Widget paddingVertical(double value) => Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);
  Widget get centered => Center(child: this);
  Widget get expanded => Expanded(child: this);
  Widget get flexible => Flexible(child: this);
}

extension NumX on num {
  Widget get horizontalSpace => SizedBox(width: toDouble());
  Widget get verticalSpace => SizedBox(height: toDouble());
}
