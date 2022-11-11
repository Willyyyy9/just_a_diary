import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../config/color_palette.dart';

class TermCard extends StatelessWidget {
  const TermCard({Key? key, required this.ruleNumber, required this.ruleText})
      : super(key: key);
  final String ruleNumber;
  final String ruleText;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              const TextSpan(
                  text: "Rule ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.textColor,
                    fontSize: 32,
                  )),
              TextSpan(
                  text: "#$ruleNumber",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[300],
                    fontSize: 32,
                  )),
            ])),
            const SizedBox(
              height: 32,
            ),
            AutoSizeText(
              ruleText,
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorPalette.textColor,
                fontSize: 28,
              ),
              maxLines: 7,
            ),
            const Spacer(),
            const Center(
              child: Text(
                "Terms and Conditions",
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
