import 'package:flutter/material.dart';

class MoodWidget extends StatelessWidget {
  const MoodWidget({Key? key, required this.moodName, required this.moodColor})
      : super(key: key);
  final String moodName;
  final Color moodColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 20,
            decoration: BoxDecoration(
                color: moodColor, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(moodName)
        ],
      ),
    );
  }
}
