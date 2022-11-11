import 'package:diary/config/constants.dart';
import 'package:diary/model/message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/color_palette.dart';

class SupportDialog extends StatefulWidget {
  const SupportDialog({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  bool isDialogDisabled = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Stack(
        children: [
          Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.xmark,
                  color: ColorPalette.textColor,
                ),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          Center(
            child: Image.asset(
              widget.message.image,
              height: 200,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              widget.message.title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: ColorPalette.textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.message.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorPalette.textColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            width: 150,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.orange,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CheckboxListTile(
            activeColor: Colors.orange,
            checkColor: ColorPalette.textColor,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            title: const Text(
              "Don't show this again",
              style: TextStyle(color: ColorPalette.textColor),
            ),
            contentPadding: EdgeInsets.zero,
            value: isDialogDisabled,
            onChanged: (newValue) async {
              setState(() {
                isDialogDisabled = newValue!;
              });

              Constants.setBoolForKey(
                  Constants.isDialogDisabledKey, isDialogDisabled);
            },
            controlAffinity: ListTileControlAffinity.leading,
          )
        ],
      ),
    );
  }
}
