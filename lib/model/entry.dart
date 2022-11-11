import 'package:objectbox/objectbox.dart';

@Entity()
@Sync()
class Entry {
  int id;
  String title;
  DateTime date;
  String mood;
  String description;

  Entry({
    this.id = 0,
    required this.date,
    required this.description,
    required this.mood,
    required this.title,
  });
}
