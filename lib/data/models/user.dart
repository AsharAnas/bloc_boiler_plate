import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.completed, this.user});

  final bool completed;
  final UserData? user;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(completed: json['Completed'] as bool? ?? false, user: json['Data'] != null ? UserData.fromJson(json['Data'] as Map<String, dynamic>) : null);
  }

  @override
  List<Object?> get props => [completed, user];
}

class UserData extends Equatable {
  const UserData({this.id, this.email, this.name, this.phone, this.isActive, this.isDeleted, this.otpValidated, this.fcmToken, this.deviceId, this.profilePicture, this.raw});

  final String? id;
  final String? email;
  final String? name;
  final String? phone;
  final bool? isActive;
  final bool? isDeleted;
  final bool? otpValidated;
  final String? fcmToken;
  final String? deviceId;
  final String? profilePicture;
  final Map<String, dynamic>? raw;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['CustomerId']?.toString(),
      email: json['Email'] as String?,
      name: json['Name'] as String?,
      phone: json['Phone'] as String?,
      isActive: json['Active'] as bool?,
      isDeleted: json['IsDeleted'] as bool?,
      otpValidated: json['OTPValidated'] as bool?,
      fcmToken: json['FCMToken'] as String?,
      deviceId: json['DeviceID'] as String?,
      profilePicture: json['ProfilePicture'] as String?,
      raw: Map<String, dynamic>.from(json),
    );
  }

  @override
  List<Object?> get props => [id, email, name, phone, isActive, isDeleted, otpValidated];
}
