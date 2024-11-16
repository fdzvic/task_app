import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String name;
  final String lastName;
  final String email;

  final String? createdAt;

  const UserData({
    required this.name,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [name, lastName, email, createdAt];

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'createdAt': createdAt,
    };
  }

  UserData copyWith({
    String? name,
    String? lastName,
    String? email,
    String? createdAt,
  }) {
    return UserData(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
