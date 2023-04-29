class Massage {
  final String massages;
  final String email;
  final String usernam;
  final bool isSender;
  Massage(this.massages, this.email, this.usernam, this.isSender);

  factory Massage.fromjson(jsonData) {
    return Massage(
      jsonData['masage'],
      jsonData['email'],
      jsonData['nameSender'],
      jsonData['seen'],
    );
  }
}
