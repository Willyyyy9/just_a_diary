import 'package:flutter/material.dart';

import '../../config/color_palette.dart';
import '../../config/constants.dart';
import '../../model/entry.dart';

class EntryDetailsScreen extends StatefulWidget {
  const EntryDetailsScreen({Key? key, required this.entry}) : super(key: key);
  final Entry entry;

  @override
  State<EntryDetailsScreen> createState() => _EntryDetailsScreenState();
}

class _EntryDetailsScreenState extends State<EntryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorPalette.textColor),
        centerTitle: false,
        title: const Text("Diary",
            style: TextStyle(
                color: ColorPalette.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: widget.entry.date.day.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: ColorPalette.textColor)),
                          TextSpan(
                              text: Constants.formatMonth(widget.entry.date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: ColorPalette.textColor))
                        ]),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Row(
                    children: [
                      Text(
                        widget.entry.mood == "" ? "Mood" : widget.entry.mood,
                        style: const TextStyle(),
                      ),
                      if (widget.entry.mood == "")
                        const SizedBox(
                          width: 5,
                        ),
                      if (widget.entry.mood == "")
                        const Icon(
                          Icons.add_circle_outline,
                          size: 18,
                        ),
                    ],
                  ),
                  backgroundColor: widget.entry.mood == ""
                      ? Colors.orangeAccent
                      : Constants.moods
                          .where(
                              (element) => element["mood"] == widget.entry.mood)
                          .first['color'],
                ),
              ],
            ),
            const Divider(),
            Text(
              widget.entry.title,
              style: const TextStyle(
                  color: ColorPalette.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Text(
                widget.entry.description,
                style: const TextStyle(
                    color: ColorPalette.textColor, fontSize: 18),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
