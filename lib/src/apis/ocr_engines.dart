// ignore: import_of_legacy_library_into_null_safe
import 'package:uni_ocr_client/uni_ocr_client.dart';

class OcrEnginesApi {
  Future<List<OcrEngineConfig>> list() async {
    return [];
  }

  Future<OcrEngineConfig> get() async {
    throw UnimplementedError();
  }

  Future<DetectTextResponse> detectText(DetectTextRequest request) async {
    throw UnimplementedError();
  }
}
