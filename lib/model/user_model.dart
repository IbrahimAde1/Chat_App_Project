class Users {
  final String email;
  final String user;
  Users(this.email, this.user);
  factory Users.fromjson(jsaonData) {
    return Users(jsaonData['name'], jsaonData['email']);
  }
}
