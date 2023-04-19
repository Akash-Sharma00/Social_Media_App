import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  
  String id;
  String content;
  String username;
  String userImage;
  String date;
  CommentModel({
    required this.id,
    required this.content,
    required this.username,
    required this.userImage,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'username': username,
      'userImage': userImage,
      'date': date,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? "NA",
      content: map['content'] ?? "NA",
      username: map['username'] ?? "NA",
      userImage: map['userImage'] ?? "NA",
      date: map['date'] ?? "NA",
    );
  }

  String toJson() => json.encode(toMap());

  // factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
