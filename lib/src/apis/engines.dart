// ignore: import_of_legacy_library_into_null_safe
import 'package:uni_translate_client/uni_translate_client.dart';

class EnginesApi {
  Future<List<TranslationEngineConfig>> list() async {
    return [];
  }

  Future<TranslationEngineConfig> get() async {
    throw UnimplementedError();
  }

  Future<DetectLanguageResponse> detectLanguage(
      DetectLanguageRequest request) async {
    throw UnimplementedError();
  }

  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    throw UnimplementedError();
  }

  Future<TranslateResponse> translate(TranslateRequest request) async {
    throw UnimplementedError();
  }
}
