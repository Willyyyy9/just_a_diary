import 'package:diary/pages/post/post_entry_screen.dart';
import 'package:flutter/material.dart';

import '../../../config/color_palette.dart';

class PostButton extends StatelessWidget {
  const PostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PostEntryScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
            color: ColorPalette.buttonColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(5)),
        child: const Icon(
          Icons.add,
          color: ColorPalette.textColor,
        ),
      ),
    );
  }
}
