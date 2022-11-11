import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/color_palette.dart';


class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/girlwithlaptop.png",
                        height: 350,
                      ),
                      Text(
                        "No Data is Found",
                        style: GoogleFonts.lato(
                            color: ColorPalette.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Submit your first entry of the day",
                        style: GoogleFonts.lato(
                            color: ColorPalette.textColor, fontSize: 18),
                      )
                    ],
                  );
  }
}