import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/logic/data_base_cubit.dart';
import 'package:sqflite_app/presentation/widgets/my_action_button.dart';
import 'package:sqflite_app/presentation/widgets/note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sqlite CRUD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<DataBaseCubit, DataBaseState>(
        builder: (context, state) {
          if (state is DataBaseInitial) {
            BlocProvider.of<DataBaseCubit>(context).getAllNotesFromDatabase();
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataBaseLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_, index) {
                return NoteCard(notes: state.notes[index]);
              },
            );
          } else if (state is DataBaseEmpty) {
            return const Center(
              child: Text('No notes available'),
            );
          } else if (state is DataBaseError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: const MyActionButton(),
    );
  }
}
