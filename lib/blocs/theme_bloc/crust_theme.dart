import 'package:flutter/material.dart';

class CrustTheme {
  late final Color background;
  late final Color onBackground;
  late final Color primary1;
  late final Color primary2;
  late final Color card;
  late final Color cardStroke;
  late final Color primaryText;
  late final Color secondaryText;
  late final Color accent;

  CrustTheme.dark() {
    background = const Color(0xff15181D);
    onBackground = const Color(0xffffffff);
    primary1 = const Color(0xffD32701);
    primary2 = const Color(0xffFF680D);
    card = const Color(0xff22262E);
    cardStroke = const Color(0xff3D4453);
    primaryText = const Color(0xffffffff);
    secondaryText = const Color(0xff757D8A);
    accent = const Color(0xffD32701);
  }

  CrustTheme.light() {
    onBackground = const Color(0xffFFF8F8);
    background = const Color(0xffffffff);
    primary1 = const Color(0xffD32701);
    primary2 = const Color(0xffFF680D);
    card = const Color(0xffFFF1F1);
    cardStroke = const Color(0xff5C3F3F);
    primaryText = const Color(0xff520000);
    secondaryText = const Color(0xff5C3F3F);
    accent = const Color(0xffD32701);
  }
}
