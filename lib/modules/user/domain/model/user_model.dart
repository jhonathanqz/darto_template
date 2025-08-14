// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String password;
  final String name;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toCreate() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory UserModel.createUser({
    required String email,
    required String password,
    required String name,
  }) {
    return UserModel(
      id: '',
      email: email,
      password: password,
      name: name,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      id: map['_id'] as String,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(email: $email, password: $password, name: $name)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ name.hashCode;
}
