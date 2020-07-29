@JS()
library fb_flutter.js;

import "package:js/js.dart";

@JS('FacebookLogin')
class FacebookLogin {
  external FacebookLogin();

  external login(permissions);
  external testAPI();
  external logout();
  external getAccessToken();
}

class FacebookLoginJsClient {
  var _client = FacebookLogin();

  login([permissions]) {
    return _client.login(permissions);
  }

  testAPI() {
    return _client.testAPI();
  }

  logout() {
    return _client.logout();
  }

  getAccessToken() {
    return _client.getAccessToken();
  }
}
