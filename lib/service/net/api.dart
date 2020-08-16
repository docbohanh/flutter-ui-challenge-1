import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String json) {
  return compute(_parseAndDecode, json);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    init();
  }

  void init();
}

abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseRespData{code: $code, message: $message, data: $data}';
  }
}

class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}
