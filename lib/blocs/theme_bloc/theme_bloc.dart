import 'package:bloc/bloc.dart';
import 'package:crust_and_co/blocs/theme_bloc/crust_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  CrustTheme crustTheme;
  ThemeType themeType = ThemeType.dark;
  ThemeBloc(this.crustTheme) : super(DarkThemeState()) {
    on<ThemeChanged>((event, emit) {
      if (event.themeType == ThemeType.dark) {
        themeType = ThemeType.dark;
        crustTheme = CrustTheme.dark();
        emit(DarkThemeState());
      } else {
        themeType = ThemeType.light;
        crustTheme = CrustTheme.light();
        emit(LightThemeState());
      }
    });
  }
}
