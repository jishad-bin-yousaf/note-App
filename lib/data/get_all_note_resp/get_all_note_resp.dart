import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:note_app/data/note_app_model/note_app_model.dart';

part 'get_all_note_resp.g.dart';

@JsonSerializable()
class GetAllNoteResp {
  @JsonKey(name: 'data')
  List<NoteAppModel> data;

  GetAllNoteResp({this.data = const []});

  factory GetAllNoteResp.fromJson(Map<String, dynamic> json) {
    return _$GetAllNoteRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllNoteRespToJson(this);
}
