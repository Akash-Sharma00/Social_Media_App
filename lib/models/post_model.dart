// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class PostModel {
  String? id;
  String? name;
  String? content;
  int likeCount;
  String? userID;
  String? date;
  String? fileLink;
  String UserImage;
  PostModel(
      {this.id,
      this.name,
      this.content,
      required this.likeCount,
      this.userID,
      this.date,
      this.fileLink,
      required this.UserImage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'content': content,
      'likeCount': likeCount,
      'userID': userID,
      'date': date,
      'fileLink': fileLink,
      'UserImage': UserImage
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      likeCount: map['likeCount'] as int,
      userID: map['userID'] != null ? map['userID'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      fileLink: map['fileLink'] != null ? map['fileLink'] as String : '',
      UserImage: map['UserImage'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
