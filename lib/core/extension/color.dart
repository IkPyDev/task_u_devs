import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  LightColors get colors => LightColors();
  Color transFormColors(Color color) => LightColors.transformColor(color);
}


abstract class StaticColors {
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const white2 = Color(0xFFF8F8F8);
  static const onBlue = Color(0xFF009FEE);
  static const blue = Color(0xFF009FEE);
  static const red = Color(0xFFEE2B00);

  static const green = Color(0xFF00C853);
  static const yellow = Color(0xFFFFD600);
  static const purple = Color(0xFF7C4DFF);
  static const pink = Color(0xFFE91E63);
  static const orange = Color(0xFFEE8F00);
  static const solitude = Color(0xFFF2F2F7);
  static const mountainMeadow = Color(0xFF14B8A6);
  static const grey = Color(0xFFF3F4F6);
  static const payneGrey = Color(0xFF3C3C43);
  static const ghost = Color(0xFFC7C7CC);
  static const whiteSmoke = Color(0xFFF7F7F7);
  static const dodgerBlue = Color(0xFF007BFE);
  static const summerSky = Color(0xFF2DAFE7);
  static const stormGrey = Color(0xFF767680);
  static const mischka = Color(0xFF999999);
  static const pattensBlue = Color(0xFFF7F9FC);
  static const whiteLilac = Color(0xFFE6E6EB);
  static const watercourse = Color(0xFF067647);
  static const magicMint = Color(0xFFABEFC6);
  static const lemonChiffon = Color(0xFFFFFCC2);
  static const darkGoldenrod = Color(0xFFD29404);
  static const onRed = Color(0xFFFF382B);


}

class LightColors {

  final primary = StaticColors.onBlue;
  final onPrimary = StaticColors.white;
  final onTextPrimary = StaticColors.white;
  final onPrimary2 = StaticColors.white2;

  final bgColor = StaticColors.solitude;
  final systemBlack = StaticColors.black;
  final systemGrey = StaticColors.grey;
  final systemGrey2 = StaticColors.mischka;
  final systemGrey3 = StaticColors.ghost;
  final systemGrey5 = StaticColors.whiteLilac;
  final labelTertiary = StaticColors.payneGrey;
  final greyBackground = StaticColors.whiteSmoke;
  final systemBlue = StaticColors.dodgerBlue;
  final systemCyan = StaticColors.summerSky;
  final fillTertiary = StaticColors.stormGrey;
  final fillTertiary08 = StaticColors.stormGrey.withOpacity(0.08);
  final onboardDot = StaticColors.pattensBlue;
  final success700 = StaticColors.watercourse;
  final success200 = StaticColors.magicMint;
  final cardCollecting = StaticColors.lemonChiffon;
  final cardCollectingText = StaticColors.darkGoldenrod;
  final systemRed = StaticColors.onRed;

  final blueSelect = StaticColors.blue;
  final redSelect = StaticColors.red;
  final greenSelect = StaticColors.green;
  final yellowSelect = StaticColors.yellow;
  final purpleSelect = StaticColors.purple;
  final pinkSelect = StaticColors.pink;
  final orangeSelect = StaticColors.orange;
  final whiteSelect = StaticColors.white;
  final blackSelect = StaticColors.black;

  static Color transformColor(Color color) {
    // Qizil (Red), Yashil (Green), va Ko'k (Blue) komponentlarini o'zgartirish.
    int newRed = (color.red + 5).clamp(0, 255); // R uchun o'zgarish misoli
    int newGreen = (color.green - 49).clamp(0, 255); // G uchun o'zgarish
    int newBlue = (color.blue - 111).clamp(0, 255); // B uchun o'zgarish

    return Color.fromARGB(color.alpha, newRed, newGreen, newBlue);
  }

}
