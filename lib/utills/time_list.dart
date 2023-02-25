import 'dart:ui';

List<String> businessHourList = ["09:00", "09:30", "10:00","10:30", "11:00", "11:30","12:00","12:30","13:00", "13:30","14:00","15:00","16:00", "16:30","17:00","17:30","18:00","18:30","19:00"];


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}