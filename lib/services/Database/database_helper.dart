import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/note_model.dart';

class DatabaseHelper {
  static const String tableName = 'notes';

  Database? _database;

  getDatabase() async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  Future initializeDatabase() async {
    String directory = await getDatabasesPath(); //* c:/documents/
    String path = join(directory, 'notes.db'); //* c:/documents/notes.db
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        Batch batch = db.batch();
        batch.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');

        batch.commit();
      },
    );
  }

  deleAllNotes() async {
    Database db = await getDatabase();
    db.execute('DELETE FROM $tableName');
  }

  Future<int> addNote(NoteModel note) async {
    Database db = await getDatabase();
    return await db.insert(tableName, note.toMap());
  }

  Future<int> updateNoteContent(NoteModel note) async {
    Database db = await getDatabase();
    return await db
        .update(tableName, note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    Database db = await getDatabase();
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NoteModel>> getNotes() async {
    Database db = await getDatabase();

    List<Map> notes = await db.query(tableName);
    return notes
        .map(
          (note) => NoteModel(
              title: note['title'], content: note['content'], id: note['id']),
        )
        .toList();
  }
}
