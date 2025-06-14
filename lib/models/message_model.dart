import 'package:chat_app2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message(
      {required this.message,
      required this.id,
      required this.timestamp,
      required this.username});
  final String message;
  final String id;
  final String username;
  final Timestamp timestamp;

  factory Message.fromJson(jsonData) {
    return Message(
        message: jsonData[kMessage],
        id: jsonData[kMessageId],
        timestamp: jsonData[kCreatedAt],
        username: jsonData[kUsername]);
  }
}
