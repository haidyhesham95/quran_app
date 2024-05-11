import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  static ThemeCubit get(context) => BlocProvider.of(context);
  static const String _themePreferenceKey = 'theme_preference';

  bool _isDark = false;
  bool get isDark => _isDark;

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_themePreferenceKey) ?? false;
    emit(ThemeChanged());
  }

  Future<void> saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, isDark);
  }

  void changeTheme() {
    _isDark = !_isDark;
    saveTheme(_isDark); // Save the theme preference
    emit(ThemeChanged());
  }

  // bool _isDark = false;
  // bool get isDark => _isDark;
  //
  // void changeTheme() {
  //   _isDark = !_isDark;
  //
  //   emit(ThemeChanged());
  // }



}







