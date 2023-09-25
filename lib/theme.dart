import 'package:astronomy_picture/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static getTheme() => ThemeData(
        primaryColor: CustomColors.blue,
        primaryColorDark: CustomColors.blueDarker,
        scaffoldBackgroundColor: CustomColors.spaceBlue,
        appBarTheme: AppBarTheme(
          color: CustomColors.black,
          iconTheme: IconThemeData(color: CustomColors.palePink),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: CustomColors.black,
          selectedItemColor: CustomColors.palePink,
          unselectedItemColor: CustomColors.palePink.withOpacity(0.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:
              ElevatedButton.styleFrom(backgroundColor: CustomColors.vermilion),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: CustomColors.spaceBlue,
          contentTextStyle: TextStyle(color: CustomColors.white),
        ),
        drawerTheme: DrawerThemeData(backgroundColor: CustomColors.black),
      );
}
