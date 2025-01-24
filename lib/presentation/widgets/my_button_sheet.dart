import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/data_base_cubit.dart';

Future<dynamic> showMySheet(BuildContext context,
    {Function()? opPressed, String buttonText = 'Add Note'}) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: context.read<DataBaseCubit>().titleController,
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusColor: Colors.blue,
                  fillColor: Colors.blue,
                  hoverColor: Colors.blue),
            ),
            TextField(
              controller: context.read<DataBaseCubit>().contentController,
              decoration: const InputDecoration(
                  labelText: 'Content',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusColor: Colors.blue,
                  fillColor: Colors.blue,
                  hoverColor: Colors.blue),
            ),
            ElevatedButton(
              onPressed: opPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      );
    },
  );
}
