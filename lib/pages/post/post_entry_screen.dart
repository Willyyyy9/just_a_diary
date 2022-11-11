import 'package:diary/config/color_palette.dart';
import 'package:diary/config/constants.dart';
import 'package:diary/pages/post/widgets/mood_chip.dart';
import 'package:diary/pages/post/widgets/submit_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart';
import '../../model/entry.dart';

class PostEntryScreen extends StatefulWidget {
  const PostEntryScreen({Key? key}) : super(key: key);

  @override
  State<PostEntryScreen> createState() => _PostEntryScreenState();
}

class _PostEntryScreenState extends State<PostEntryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String selectedMood = "";
  DateTime? selectedDateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void submitEntry() async {
    final Entry entry = Entry(
        date: selectedDateTime ?? DateTime.now(),
        mood: selectedMood,
        title: titleController.text,
        description: messageController.text);
    await saveEntryDate();
    objectBox.insertEntry(entry);
    Constants.setStringForKey(Constants.savedTitleKey, "");
    Constants.setStringForKey(Constants.savedMessageKey, "");
  }

  Future<void> saveEntryDate() async {
    final dateTimeList =
        await Constants.getStringListForKey(Constants.dateTimeListKey);
    bool isEntrySubmittedOnSameDay = dateTimeList
        .contains(selectedDateTime!.millisecondsSinceEpoch.toString());
    if (!isEntrySubmittedOnSameDay) {
      dateTimeList.add(selectedDateTime!.millisecondsSinceEpoch.toString());
      Constants.setStringListForKey(Constants.dateTimeListKey, dateTimeList);
    }
  }

  void datePicker(BuildContext context) async {
    setState(() {});
    selectedDateTime = await showDatePicker(
        context: context,
        initialDate: selectedDateTime ?? DateTime.now(),
        firstDate: DateTime.utc(DateTime.now().year - 1),
        lastDate: DateTime.utc(DateTime.now().year + 1),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        builder: (context, child) {
          return Theme(
            data: ThemeData().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorPalette.buttonColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: ColorPalette.textColor,
                  ),
                ),
                dialogBackgroundColor: ColorPalette.backgroundColor),
            child: child!,
          );
        });
    setState(() {});
  }

  Future<void> getSavedDraft() async {
    String title = await Constants.getStringForKey(Constants.savedTitleKey);
    String message = await Constants.getStringForKey(Constants.savedMessageKey);
    titleController.text = title;
    messageController.text = message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Write",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: ColorPalette.textColor.withOpacity(0.5),
                )),
          ],
        ),
        body: FutureBuilder(
            future: getSavedDraft(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextButton(
                              onPressed: () => datePicker(context),
                              child: Row(
                                children: [
                                  Text(
                                    selectedDateTime == null ||
                                            (selectedDateTime!.day ==
                                                    DateTime.now().day &&
                                                selectedDateTime!.month ==
                                                    DateTime.now().month &&
                                                selectedDateTime!.year ==
                                                    DateTime.now().year)
                                        ? "Today"
                                        : "${selectedDateTime!.day.toString()} ${Constants.formatMonth(selectedDateTime!)}",
                                    style: const TextStyle(
                                        color: ColorPalette.textColor,
                                        fontSize: 24),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: ColorPalette.buttonColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          MoodChip(onTap: (String mood) {
                            selectedMood = mood;
                          })
                        ],
                      ),
                      const Divider(),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Submit a title" : null,
                        onChanged: (value) {
                          formKey.currentState!.validate();
                        },
                        controller: titleController,
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                            color: ColorPalette.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        cursorColor: ColorPalette.buttonColor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: TextStyle(
                                color: ColorPalette.textColor.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0)),
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? "Submit a message" : null,
                          onChanged: (value) {
                            formKey.currentState!.validate();
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: messageController,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                              color: ColorPalette.textColor, fontSize: 18),
                          cursorColor: ColorPalette.buttonColor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "What's going on?",
                              hintStyle: TextStyle(
                                  color:
                                      ColorPalette.textColor.withOpacity(0.5),
                                  fontSize: 18),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16)),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                Constants.setStringForKey(
                                    Constants.savedTitleKey,
                                    titleController.text);
                                Constants.setStringForKey(
                                    Constants.savedMessageKey,
                                    messageController.text);
                                Fluttertoast.showToast(
                                    msg: "Draft Saved",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.textColor,
                                    textColor: ColorPalette.backgroundColor,
                                    fontSize: 16.0);
                              },
                              icon: const Icon(
                                Icons.save_alt,
                                color: ColorPalette.textColor,
                              )),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  messageController.text = "";
                                  titleController.text = "";
                                });
                                Constants.setStringForKey(
                                    Constants.savedTitleKey,
                                    titleController.text);
                                Constants.setStringForKey(
                                    Constants.savedMessageKey,
                                    messageController.text);
                                Fluttertoast.showToast(
                                    msg: "Draft Cleared",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: ColorPalette.textColor,
                                    textColor: ColorPalette.backgroundColor,
                                    fontSize: 16.0);
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: ColorPalette.textColor,
                              )),
                          const Spacer(),
                          TextButton(
                              onPressed: () async {
                                EasyLoading.show(
                                    status: 'Submitting Entry',
                                    maskType: EasyLoadingMaskType.custom);

                                if (formKey.currentState!.validate() &&
                                    selectedMood != "") {
                                  submitEntry();
                                  Navigator.pop(context);
                                } else if (selectedMood == "") {
                                  EasyLoading.showError(
                                      "Please select your mood");
                                }
                                EasyLoading.dismiss();
                              },
                              child: const SubmitChip()),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
