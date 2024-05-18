part of 'theme_cubit.dart';


// abstract class ThemeState {}
//
// class ThemeInitial extends ThemeState {}
// class ThemeChanged extends ThemeState {}
class ThemeState {
  final ThemeMode themeMode;

  ThemeState({this.themeMode = ThemeMode.system});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}