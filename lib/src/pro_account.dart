import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

import '../pro_account.dart';
import 'apis/engines.dart';
import 'apis/ocr_engines.dart';
import 'apis/versions.dart';

class ProAccount {
  ProAccount._() {
    this._enginesApi = EnginesApi();
    this._ocrEnginesApi = OcrEnginesApi();
    this._versionsApi = VersionsApi();
  }

  /// The shared instance of [ProAccount].
  static final ProAccount instance = ProAccount._();

  late EnginesApi _enginesApi;
  late OcrEnginesApi _ocrEnginesApi;
  late VersionsApi _versionsApi;

  Directory? dataDirectory;
  Session? lastSession;

  Future<void> ensureInitialized() async {
    if (!kIsWeb) {
      final docDir = await getApplicationDocumentsDirectory();
      dataDirectory = Directory('${docDir.path}/biyiapp-dev');
      if (!dataDirectory!.existsSync()) {
        dataDirectory!.createSync(recursive: true);
      }
      File sessionFile = File('${dataDirectory!.path}/session.json');
      if (sessionFile.existsSync()) {
        final String jsonString = await sessionFile.readAsString();
        if(jsonString.isNotEmpty) {
          lastSession = Session.fromJson(json.decode(jsonString));
        }
      }
    }
  }

  Guest? get loggedInGuest {
    return lastSession?.targetGuest;
  }

  Future<Session> _login(
    String loginAs,
    String username,
    String password, {
    Guest? targetGuest,
  }) async {
    Session session = Session(id: 0, targetType: kLoginAsGuest);
    session.targetGuestId = targetGuest?.id;
    session.targetGuest = targetGuest;
    final String jsonString = json.encode(session.toJson());

    if (!kIsWeb) {
      File sessionFile = File('${dataDirectory!.path}/session.json');
      await sessionFile.writeAsString(jsonString);
    }
    return session;
  }

  Future<Session> loginAsGuest() async {
    Guest guest;
    if (!kIsWeb) {
      File guestFile = File('${dataDirectory!.path}/guest.json');
      if (!guestFile.existsSync()) {
        guest = Guest(id: 0, guestKey: Uuid().v4(), guestToken: "");
        final String jsonString = json.encode(guest.toJson());
        await guestFile.writeAsString(jsonString);
      } else {
        final String jsonString = await guestFile.readAsString();
        guest = Guest.fromJson(json.decode(jsonString));
      }
    } else {
      guest = Guest(id: 0, guestKey: Uuid().v4(), guestToken: "");
    }

    return _login(kLoginAsGuest, guest.guestKey, guest.guestToken);
  }

  EnginesApi get engines => this.engine(null);

  EnginesApi engine(String? id) {
    return _enginesApi;
  }

  OcrEnginesApi get ocrEngines => this.ocrEngine(null);

  OcrEnginesApi ocrEngine(String? id) {
    return _ocrEnginesApi;
  }

  VersionsApi get versions => this.version(null);

  VersionsApi version(String? id) {
    return _versionsApi;
  }
}
