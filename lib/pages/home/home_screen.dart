import 'package:diary/config/constants.dart';
import 'package:diary/main.dart';
import 'package:diary/model/entry.dart';
import 'package:diary/pages/home/widgets/empty_state.dart';
import 'package:diary/pages/home/widgets/entry_item.dart';
import 'package:diary/pages/home/widgets/horizontal_calender.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomIndex = 0;
  bool isDialogShowed = false;
  DateTime selectedDateTime = DateTime.now();

  void handleSupportDialog() {
    Constants.getOverallMood(context);
    if (!Constants.isSupportDialogDisabled!) {
      Constants.getOverallMood(context);
      Constants.isSupportDialogDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        HorizontalCalender(
          onTap: (DateTime thisDateTime) {
            selectedDateTime = thisDateTime;
            setState(() {});
          },
        ),
        StreamBuilder<List<Entry>>(
            stream: objectBox.getDateEntries(selectedDateTime),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                handleSupportDialog();
                final entries = snapshot.data!;
                if (entries.isEmpty) {
                  return const EmptyState();
                } else {
                  return Flexible(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          return EntryItem(entry: entries[index]);
                        },
                      ),
                    ),
                  );
                }
              }
            }))
      ]),
    );
  }
}
