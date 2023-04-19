import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessageModel {
  final String? userid;
  final String? message;
  final String? file;
  final String? date;
  ChatMessageModel({
    required this.userid,
    required this.message,
    required this.file,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'message': message,
      'file': file,
      'date': date,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      userid: map['userid']  ??'',
      message: map['message'] ?? '',
      file: map['file'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory ChatMessageModel.fromJson(String source) => ChatMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
