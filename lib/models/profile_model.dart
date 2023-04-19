import 'dart:convert';

class ProfileModel {
  String? id;
  String? name;
  String? email;
  String? username;
  String? number;
  String? description;
  String? imagelink;
  String? hobby;
  ProfileModel({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.hobby,
    required this.imagelink,
    required this.number,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'number': number,
      'description': description,
      'imagelink': imagelink,
      'hobby': hobby,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      imagelink: map['imagelink'] != null ? map['imagelink'] as String : null,
      hobby: map['hobby'] != null ? map['hobby'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
