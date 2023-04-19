// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatRoomModel {
   String conecteid;
   String roomid;
   String? image;
   String? lastmessage;
   String?  imagelocal;
   String? time;
   String name;
   
   ChatRoomModel({
    required this.image,
    required this.conecteid,
    required this.imagelocal,
    required this.lastmessage,
    required this.roomid,
    required this.time,
    required this.name,
   });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conecteid': conecteid,
      'roomid': roomid,
      'image': image,
      'lastmessage': lastmessage,
      'imagelocal': imagelocal,
      'time': time,
      'name': name,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      conecteid: map['conecteid'] ?? "",
      roomid: map['roomid'] ?? "",
      image: map['image'] != null ? map['image'] ?? "" : null,
      lastmessage: map['lastmessage'] != null ? map['lastmessage'] ?? "" : null,
      imagelocal: map['imagelocal'] != null ? map['imagelocal'] ?? "" : null,
      time: map['time'] != null ? map['time'] ?? "" : null, name: map["name"]??"",
    );
  }

  String toJson() => json.encode(toMap());

  // factory ChatRoomModel.fromJson(String source) => ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
