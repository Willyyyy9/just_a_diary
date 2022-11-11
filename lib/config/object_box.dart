import 'package:diary/model/entry.dart';
import 'package:diary/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<Entry> _entryBox;

  ObjectBox._init(this._store) {
    _entryBox = Box<Entry>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    if (Sync.isAvailable()) {
      final syncClient =
          Sync.client(store, "ws://0.0.0.0:9999", SyncCredentials.none());
      syncClient.start();
    }
    return ObjectBox._init(store);
  }

  Entry? getEntry(int id) => _entryBox.get(id);

  Stream<List<Entry>> getEntries() =>
      _entryBox.query().watch(triggerImmediately: true).map(
            (query) => query.find(),
          );

  Stream<List<Entry>> getDateEntries(DateTime dateTime) => _entryBox
      .query(Entry_.date.between(
          DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00)
              .millisecondsSinceEpoch,
          DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
              .millisecondsSinceEpoch))
      .watch(triggerImmediately: true)
      .map(
        (query) => query.find(),
      );

      Stream<List<Entry>> getMonthEntries() => _entryBox
      .query(Entry_.date.between(
          DateTime(DateTime.now().year, DateTime.now().month, 1, 00, 00)
              .millisecondsSinceEpoch,
          DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59)
              .millisecondsSinceEpoch))
      .watch(triggerImmediately: true)
      .map(
        (query) => query.find(),
      );

  int insertEntry(Entry entry) => _entryBox.put(entry);

  bool deleteEntry(int id) => _entryBox.remove(id);
}
