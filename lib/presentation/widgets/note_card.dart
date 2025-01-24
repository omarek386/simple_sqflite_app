import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_app/logic/data_base_cubit.dart';
import 'package:sqflite_app/models/note_model.dart';
import 'package:sqflite_app/presentation/widgets/my_button_sheet.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  NoteCard({
    required this.notes,
    super.key,
  });
  NoteModel notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: ListTile(
        tileColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.read<DataBaseCubit>().setTitle = notes.title;
                context.read<DataBaseCubit>().setContent = notes.content;
                showMySheet(
                  buttonText: 'Update Note',
                  context,
                  opPressed: () {
                    context.read<DataBaseCubit>().updateNoteInDatabase(notes);
                    Navigator.pop(context);
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<DataBaseCubit>().deleteNoteFromDatabase(notes);
              },
            ),
          ],
        ),
        title: Text(notes.title),
        subtitle: Text(notes.content),
      ),
    );
  }
}
