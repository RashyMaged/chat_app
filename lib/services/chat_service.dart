import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    ChatMessage newMessage = ChatMessage(
        
        text: message,
        senderId: currentUserId,
        recieverId: receiverId,
        senderEmail: currentUserEmail,
        timestamp: timestamp);
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // to ensure chatID is the same for any 2 people
    String chatId = ids.join('_');
    await _firestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, otheruserId) {
    List<String> ids = [userId, otheruserId];
    ids.sort();
    String chatId = ids.join('_');
    return _firestore
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
