
import 'dart:async';

import 'package:flutter/services.dart';

class Rofa {
  static const MethodChannel _channel =
      const MethodChannel('rofa');
  
  final String customSchemeForIOS;
  final String deepLink;
  
  Rofa({required this.customSchemeForIOS, required this.deepLink});

  configure() {
    _channel.setMethodCallHandler((call) {
      if (call.method == "getDeepLink") {
        return _channel.invokeMethod("getDeepLink", [deepLink]);
      } else if (call.method == "getCustomScheme") {
        return _channel.invokeMethod("getCustomScheme", [customSchemeForIOS]);
      }
      return Future.error("Unexpected method name: ${call.method}");
    });
    
    
  }
}
