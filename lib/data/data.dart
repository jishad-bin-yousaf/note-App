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

  @override
  Future<NoteAppModel?> createNote(NoteAppModel value) async {
    try {
      //  print("++++++++++++++++++");

      final _result = await dio.post<NoteAppModel>(url.baseUrl + url.createNote, data: value.toJson());
      print(_result.statusCode);

      return _result.data;
    } on DioError catch (e) {
      // print(e.response?.data);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    //  final _result = await dio.delete(url.baseUrl + url.deleteNote);
  }

  @override
  Future<List<NoteAppModel>> getAllNotes() async {
    final _result = await dio.get<GetAllNoteResp>(url.baseUrl + url.getAllNotes);
    if (_result.data == null) {
      return [];
    } else {
      return _result.data!.data;
    }
  }

  @override
  Future<NoteAppModel?> updateNote(NoteAppModel value) async {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
