import 'package:pro_account/pro_account.dart';

const kLoginAsGuest = 'guest';
const kLoginAsUser = 'user';

class Session {
  int id;
  String targetType;
  int? targetGuestId;
  Guest? targetGuest;

  String? accessToken;

  Session({
    required this.id,
    required this.targetType,
    this.targetGuestId,
    this.targetGuest,
    this.accessToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      targetType: json['target_type'],
      targetGuestId: json['target_guest_id'],
      targetGuest: json['target_guest'] != null
          ? Guest.fromJson(json['target_guest'])
          : null,
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'target_type': targetType,
      'target_guest_id': targetGuestId,
      'target_guest': targetGuest?.toJson(),
      'access_token': accessToken,
    };
  }
}
