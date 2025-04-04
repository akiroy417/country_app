class UserModel {
  final String uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;

  UserModel({
    required this.uid,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photoUrl: map['photoUrl'],
    );
  }
}