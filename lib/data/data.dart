import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:note_app/data/get_all_note_resp/get_all_note_resp.dart';
import 'package:note_app/data/note_app_model/note_app_model.dart';
import 'package:note_app/data/url.dart';

abstract class ApiCalls {
  Future<NoteAppModel?> createNote(NoteAppModel value);
  Future<NoteAppModel?> updateNote(NoteAppModel value);
  Future<void> deleteNote(String id);
  Future<List<NoteAppModel>> getAllNotes();
}

class NoteDB extends ApiCalls {
  final dio = Dio();
  final url = Url();

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<NoteAppModel?> createNote(NoteAppModel value) async {
    try {
      final _result = await dio.post(
        url.createNote,
        data: value.toJson(),
      );
      print(_result.data);

      final _resultAsJson = jsonDecode(_result.data);
      return NoteAppModel.fromJson(_resultAsJson as Map<String, dynamic>);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e.toString());

      return null;
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    //  final _result = await dio.delete(url.baseUrl + url.deleteNote);
  }

  @override
  Future<List<NoteAppModel>> getAllNotes() async {
    final result = await dio.get(url.getAllNotes);
    if (result.data != null) {
      final resultAsJson = jsonDecode(result.data);
      final getNoteResp = GetAllNoteResp.fromJson(resultAsJson);
      return getNoteResp.data;
    } else {
      return [];
    }
  }

  @override
  Future<NoteAppModel?> updateNote(NoteAppModel value) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
