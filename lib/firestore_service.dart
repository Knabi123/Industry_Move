// ignore_for_file: avoid_print, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addUser(
      String id, String password, String name, String phoneNumber) async {
    try {
      await _firestore.collection('User').add({
        'id': id,
        'password': password,
        'name': name,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // สามารถเพิ่มฟังก์ชันอื่น ๆ ที่เกี่ยวข้องกับ Firestore ต่อไปได้
}
