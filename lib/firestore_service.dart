// ignore_for_file: avoid_print, prefer_final_fields, use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/src/bottombar.dart';
import 'package:company/src_user/bottombar_user.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addUser(
      String id, String password, String name, String phoneNumber,
      {required String role}) async {
    try {
      await _firestore.collection('User').add({
        'id': id,
        'password': password,
        'name': name,
        'phoneNumber': phoneNumber,
        'role': role,
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  static Future<bool> isIdExists(String id) async {
    try {
      QuerySnapshot query =
          await _firestore.collection('User').where('id', isEqualTo: id).get();
      return query.docs.isNotEmpty;
    } catch (e) {
      print('Error checking ID existence: $e');
      return false;
    }
  }

  // static Future<bool> login(String id, String password) async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> userQuery = await _firestore
  //         .collection('User')
  //         .where('id', isEqualTo: id)
  //         .limit(1)
  //         .get();

  //     if (userQuery.docs.isNotEmpty) {
  //
  //       Map<String, dynamic> userData = userQuery.docs.first.data();

  //
  //       if (userData['password'] == password) {
  //
  //         return true;
  //       }
  //     }
  //   } catch (e) {
  //     print('Error during login: $e');
  //   }

  //
  //   return false;
  // }

  static Future<String?> getRole(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> userQuery = await _firestore
          .collection('User')
          .where('id', isEqualTo: id)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        Map<String, dynamic> userData = userQuery.docs.first.data();
        String? role = userData['role'];
        return role;
      }
    } catch (e) {
      print('Error during role retrieval: $e');
    }
    return null;
  }

  static Future<bool> login(
      String id, String password, BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> userQuery = await _firestore
          .collection('User')
          .where('id', isEqualTo: id)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        Map<String, dynamic> userData = userQuery.docs.first.data();
        if (userData['password'] == password) {
          String? role = await getRole(id);
          if (role != null) {
            switch (role) {
              case 'Customer':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBar_User(),
                  ),
                );
                break;
              case 'Company':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBar(),
                  ),
                );
                break;
              case 'Driver':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBar(),
                  ),
                );
                break;
              default:
                print('Invalid role: $role');
            }
            return true;
          }
        }
      }
    } catch (e) {
      print('Error during login: $e');
    }
    return false;
  }

  // ไว้เพิ่มฟังก์ชั่นในFirebaseส่วนฐานข้อมูลจะเพิ่มอะไรก็เพิ่มเลย
}
