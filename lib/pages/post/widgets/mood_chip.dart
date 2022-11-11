import 'package:diary/config/color_palette.dart';
import 'package:diary/config/constants.dart';
import 'package:flutter/material.dart';

class MoodChip extends StatefulWidget {
  MoodChip({Key? key, required this.onTap}) : super(key: key);
  Function onTap;

  @override
  State<MoodChip> createState() => _MoodChipState();
}

class _MoodChipState extends State<MoodChip> {
  String selectedMood = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: ColorPalette.backgroundColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    title: const Text(
                      "How's your day?",
                      textAlign: TextAlign.center,
                    ),
                    alignment: Alignment.center,
                    content: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.spaceEvenly,
                        children: Constants.moods.map((item) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.onTap(item['mood']);
                                    selectedMood = item['mood'];
                                  });

                                  Navigator.pop(context);
                                },
                                child: Chip(
                                  elevation: 1,
                                  label: Text(
                                    item["mood"],
                                  ),
                                  backgroundColor: item["color"],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          );
                        }).toList()),
                  );
                });
          },
          child: Chip(
            label: Row(
              children: [
                Text(
                  selectedMood == "" ? "Mood" : selectedMood,
                  style: const TextStyle(),
                ),
                if (selectedMood == "")
                  const SizedBox(
                    width: 5,
                  ),
                if (selectedMood == "")
                  const Icon(
                    Icons.add_circle_outline,
                    size: 18,
                  ),
              ],
            ),
            backgroundColor: selectedMood == ""
                ? Colors.orangeAccent
                : Constants.moods
                    .where((element) => element["mood"] == selectedMood)
                    .first['color'],
          ),
        ));
  }
}
