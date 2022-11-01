import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

Color kColorSecondary = Color(0xff03A69A);
Color kColorPrimary = Color(0xFFFFFFFF);
Color kColorAccent = Color(0xFF334148);
String kDefaultProfileImage = "assets/avatar_1.jpeg";
String kDefaultCartegoryImage = "assets/cartegory.png";
String kDefaultPasswordImage = "assets/computer.png";

Future<bool> requestStoragePermissions() async {
  final status = await Permission.storage.status;
  if (status.isGranted) {
    return true;
  }
  if (Platform.isAndroid) {
    final result = await Permission.storage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

Future<bool> requestManageExternalStorage() async {
  final status = await Permission.manageExternalStorage.status;
  if (status.isGranted) {
    return true;
  }
  if (Platform.isAndroid) {
    final result = await Permission.manageExternalStorage.request();
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

TextStyle Function(bool, double, {Color color}) textStyle =
    (isBold, fontSize, {Color color = const Color(0xFF334148)}) {
  return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
};

String dateFormat(DateTime date) {
  final DateFormat dateFormat = DateFormat("dd MM yyyy");
  return dateFormat.format(date);
}
