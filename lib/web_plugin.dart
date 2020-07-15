import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js_util.dart';

import 'src/interop.dart';

const pluginName = 'flutter_facebook_login_web';

class FlutterLoginFacebookWebPlugin {
  var _jsClient = FacebookLoginJsClient();

  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      pluginName,
      const StandardMethodCodec(),
      registrar.messenger,
    );
    final FlutterLoginFacebookWebPlugin instance =
        FlutterLoginFacebookWebPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'test':
        return _test(call);

      case 'login':
        return _login(call);

      case 'testApi':
        return _testApi(call);

      case 'logout':
        return _logout(call);
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The $pluginName plugin web doesn't implement "
                "the method '${call.method}'");
    }
  }

  int _test(MethodCall call) {
    return 8;
  }

  Future _login(MethodCall call) async {
    var permissions = call.arguments['permissions'];
    var results = await promiseToFuture(_jsClient.login(permissions));

    print(results);
    Map resultsMap = json.decode(results);
    print(resultsMap);
    return resultsMap;
  }

  Future _testApi(MethodCall call) async {
    var result = await promiseToFuture(_jsClient.testAPI());

    return result;
  }

  Future _logout(MethodCall call) async {
    var result = await promiseToFuture(_jsClient.logout());

    return result;
  }
}
