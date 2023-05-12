import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'color_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    //main color
    primaryColor: ColorManager.white,
    primaryColorLight: ColorManager.darkGray,
    splashColor: ColorManager.white, //ripple effect color

    //cardView theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation: AppSize.size4,
    ),

    //appBar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.black,
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      color: ColorManager.black,
      elevation: 0.0,
      shadowColor: ColorManager.darkGray,
      titleTextStyle: getRegularStyle(
        color: ColorManager.white,
        // fontSize: FontSize.size16,
      ),
    ),
    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.brown,
      splashColor: ColorManager.white,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: AppSize.size17,
        ),
        backgroundColor: ColorManager.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size16),
        ),
      ),
    ),
    scaffoldBackgroundColor: ColorManager.black,
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.size44,
      ),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.size30,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.size12,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.size24,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.size16,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.black,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.black,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.size12,
      ),
      labelSmall: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.size12,
      ),
    ),

    //inputDecoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.padding8),
      //hint style
      hintStyle: getRegularStyle(
        color: ColorManager.black,
        fontSize: FontSize.size14,
      ),
      //label style
      labelStyle: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.size14,
      ),
      //error style
      errorStyle: getRegularStyle(
        color: ColorManager.red,
      ),
      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
      //focus border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.brown,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.red,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
      //focus error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.brown,
          width: AppSize.size1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.size8),
        ),
      ),
    ),
  );
}
