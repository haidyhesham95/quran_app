// import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeInitial());
//   static ThemeCubit get(context) => BlocProvider.of(context);

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeModeKey = 'theme_mode';

  ThemeCubit() : super(ThemeState()) {
    _loadTheme();
  }

  static ThemeCubit get(context) => BlocProvider.of(context);

  void setTheme(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode.toString());
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeModeKey);
    if (themeModeString != null) {
      final themeMode = ThemeMode.values.firstWhere(
        (element) => element.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
      emit(state.copyWith(themeMode: themeMode));
    }
  }
}
