
import 'dart:async';

import 'package:flutter/services.dart';

class Rofa {
  static const MethodChannel _channel =
      const MethodChannel('rofa');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
