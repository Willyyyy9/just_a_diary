import 'package:diary/config/constants.dart';
import 'package:diary/main.dart';
import 'package:diary/model/entry.dart';
import 'package:diary/pages/entry%20details/entry_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../config/color_palette.dart';

class EntryItem extends StatelessWidget {
  const EntryItem({
    Key? key,
    required this.entry,
  }) : super(key: key);
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EntryDetailsScreen(
                  entry: entry,
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  objectBox.deleteEntry(entry.id);
                },
                backgroundColor: Colors.red.withOpacity(0.8),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(16),
                spacing: 1,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ],
              borderRadius: BorderRadius.circular(16),
              color: ColorPalette.entryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: entry.date.day.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: ColorPalette.textColor)),
                          TextSpan(
                              text: Constants.formatMonth(entry.date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: ColorPalette.textColor))
                        ]),
                      ),
                      Chip(
                        backgroundColor: Constants.moods
                            .where((mood) => entry.mood == mood["mood"])
                            .first['color'],
                        label: Text(entry.mood),
                      )
                    ]),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  entry.title,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: ColorPalette.textColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  entry.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: ColorPalette.textColor.withOpacity(0.5)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
