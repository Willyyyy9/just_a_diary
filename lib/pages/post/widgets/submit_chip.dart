import 'package:diary/config/color_palette.dart';
import 'package:flutter/material.dart';

class SubmitChip extends StatelessWidget {
  const SubmitChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: ColorPalette.buttonColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: const Text(
          "Submit",
          style: TextStyle(fontSize: 16),
        ));
  }
}
