import '../models/version.dart';

class VersionsApi {
  Future<Version> get() async {
    return Version(version: '0.0.0', buildNumber: 0, platforms: []);
  }
}
