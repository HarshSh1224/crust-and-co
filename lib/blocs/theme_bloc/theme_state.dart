part of 'theme_bloc.dart';

abstract class ThemeState {}

class DarkThemeState extends ThemeState {
  final CrustTheme theme = CrustTheme.dark();
}

class LightThemeState extends ThemeState {
  final CrustTheme theme = CrustTheme.light();
}
