import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String name;
  final String lastName;
  final String email;
  final String? pin;
  final String? createdAt;

  const UserData({
    required this.name,
    required this.lastName,
    required this.email,
    required this.pin,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [name, lastName, email, pin, createdAt];

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      pin: json['pin'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'pin': pin,
      'createdAt': createdAt,
    };
  }

  UserData copyWith({
    String? name,
    String? lastName,
    String? email,
    String? pin,
    String? createdAt,
  }) {
    return UserData(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      pin: pin ?? this.pin,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
