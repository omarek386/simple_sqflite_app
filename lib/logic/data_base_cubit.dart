import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:sqflite_app/services/Database/database_helper.dart';

import '../models/note_model.dart';

part 'data_base_state.dart';

class DataBaseCubit extends Cubit<DataBaseState> {
  DataBaseCubit() : super(DataBaseInitial());

  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  set setTitle(String title) => titleController.text = title;

  set setContent(String content) => contentController.text = content;

  void addNoteToDatabase() async {
    emit(DataBaseLoading());
    try {
      NoteModel note = NoteModel(
          title:
              titleController.text.isEmpty ? 'no title' : titleController.text,
          content: contentController.text.isEmpty
              ? 'no content'
              : contentController.text);
      int id = await databaseHelper.addNote(note);
      contentController.clear();
      titleController.clear();
      emit(DataBaseNoteAdded(id));
      getAllNotesFromDatabase();
    } catch (e) {
      emit(DataBaseError(e.toString()));
    }
  }

  Future<void> updateNoteInDatabase(NoteModel note) async {
    emit(DataBaseLoading());
    try {
      NoteModel newNote = NoteModel(
          id: note.id,
          title:
              titleController.text.isEmpty ? 'no title' : titleController.text,
          content: contentController.text.isEmpty
              ? 'no content'
              : contentController.text);
      await databaseHelper.updateNoteContent(newNote);
      emit(DataBaseNoteUpdated(note.id!));
      titleController.clear();
      contentController.clear();
      getAllNotesFromDatabase();
    } catch (e) {
      emit(DataBaseError(e.toString()));
    }
  }

  void deleteNoteFromDatabase(NoteModel note) async {
    emit(DataBaseLoading());
    try {
      await databaseHelper.deleteNote(note.id!);
      emit(DataBaseNoteDeleted(note.id!));
      getAllNotesFromDatabase();
    } catch (e) {
      emit(DataBaseError(e.toString()));
    }
  }

  void getAllNotesFromDatabase() async {
    emit(DataBaseLoading());
    try {
      List<NoteModel> notes = await databaseHelper.getNotes();
      notes.isEmpty ? emit(DataBaseEmpty()) : emit(DataBaseLoaded(notes));
    } catch (e) {
      emit(DataBaseError(e.toString()));
    }
  }

  void clearState() {
    emit(DataBaseInitial());
  }
}
