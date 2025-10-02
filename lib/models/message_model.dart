import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final String senderId;
  final String recieverId;
  final String senderEmail;
  final Timestamp timestamp;
  ChatMessage(
      {
      required this.text,
      required this.senderId,
      required this.recieverId,
      required this.senderEmail,
      required this.timestamp});
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderEmail': senderEmail,
      'senderId': senderId,
      'receiverId': recieverId,
      'timestamp': timestamp,
    };
  }
}
