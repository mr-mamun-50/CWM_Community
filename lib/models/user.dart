class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.token,
  });

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      token: json['access_token'],
    );
  }
}
