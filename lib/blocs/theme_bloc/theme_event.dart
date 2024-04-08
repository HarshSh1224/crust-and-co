part of 'theme_bloc.dart';

enum ThemeType { dark, light }

abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeType themeType;
  ThemeChanged(this.themeType);
}
