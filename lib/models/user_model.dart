
//import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserModel {
  String id;
  String name;
  String email;

  MyUserModel({required this.email, required this.id, required this.name});
  factory MyUserModel.fromJson(Map<String, dynamic> json) {
    return MyUserModel(
      email: json['email'],
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> ToFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
