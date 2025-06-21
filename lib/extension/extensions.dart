

import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext{
  Size get screenSize => MediaQuery.of(this).size;
  double get heightQuery => screenSize.height;
  double get widthQuery => screenSize.width;
}