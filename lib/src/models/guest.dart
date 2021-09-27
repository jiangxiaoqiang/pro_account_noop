class Guest {
  int id;
  String guestKey;
  String guestToken;

  Guest({
    required this.id,
    required this.guestKey,
    required this.guestToken,
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'],
      guestKey: json['guest_key'],
      guestToken: json['guest_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guest_key': guestKey,
      'guest_token': guestToken,
    };
  }
}
