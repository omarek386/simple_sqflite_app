import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/logic/data_base_cubit.dart';

import 'my_button_sheet.dart';

class MyActionButton extends StatelessWidget {
  const MyActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      shape: const CircleBorder(),
      onPressed: () {
        showMySheet(
          context,
          opPressed: () {
            BlocProvider.of<DataBaseCubit>(context).addNoteToDatabase();
            Navigator.pop(context);
          },
        );
      },
      tooltip: 'Add Note',
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
