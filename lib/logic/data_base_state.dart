part of 'data_base_cubit.dart';

@immutable
abstract class DataBaseState {}

class DataBaseInitial extends DataBaseState {}

class DataBaseLoading extends DataBaseState {}

class DataBaseLoaded extends DataBaseState {
  final List<NoteModel> notes;

  DataBaseLoaded(this.notes);
}

class DataBaseError extends DataBaseState {
  final String message;

  DataBaseError(this.message);
}

class DataBaseNoteAdded extends DataBaseState {
  final int id;

  DataBaseNoteAdded(this.id);
}

class DataBaseNoteDeleted extends DataBaseState {
  final int id;

  DataBaseNoteDeleted(this.id);
}

class DataBaseNoteUpdated extends DataBaseState {
  final int id;

  DataBaseNoteUpdated(this.id);
}

class DataBaseEmpty extends DataBaseState {}
