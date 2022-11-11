import 'package:diary/main.dart';
import 'package:diary/pages/home/widgets/empty_state.dart';
import 'package:diary/pages/home/widgets/entry_item.dart';
import 'package:flutter/material.dart';

import '../../config/color_palette.dart';
import '../../model/entry.dart';

class EntryListScreen extends StatefulWidget {
  const EntryListScreen({Key? key, required this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  State<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
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
      body: StreamBuilder<List<Entry>>(
        stream: objectBox.getDateEntries(widget.dateTime),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final entries = snapshot.data!;
            if (entries.isEmpty) {
              return const EmptyState();
            } else {
              return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: ((context, index) {
                    return EntryItem(entry: entries[index]);
                  }));
            }
          }
        },
      ),
    );
  }
}
