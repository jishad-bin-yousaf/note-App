// ignore_for_file: avoid_print, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_app_model/note_app_model.dart';
import 'package:note_app/view/screen_add_note.dart';

class ScreenAllNote extends StatefulWidget {
  @override
  State<ScreenAllNote> createState() => _ScreenAllNoteState();
}

class _ScreenAllNoteState extends State<ScreenAllNote> {
  final List<NoteAppModel> noteList = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _noteList = await NoteDB().getAllNotes();
      noteList.clear();
      setState(() {
        noteList.addAll(_noteList.reversed);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notes"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(20),
          children: List.generate(
            noteList.length,
            (index) {
              final _note = noteList[index];
              if (_note.id == null) {
                return const SizedBox();
              } else {
                return NoteItem(
                  title: _note.title ?? "No title",
                  content: _note.content ?? "No content",
                  id: _note.id,
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ScreenAddNote(
                type: ActionType.addNote,
              ),
            ),
          );
        }),
        label: const Text("New"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  String title;

  String content;

  var id;

  NoteItem({required this.title, required this.content, this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenAddNote(
              type: ActionType.editNote,
            ),
          ),
        );
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (() {}),
                  icon: const Icon(Icons.delete, color: Colors.red),
                )
              ],
            ),
            Text(
              content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
