import 'dart:async';

import 'package:flutter/services.dart';

import 'src/clock.dart';

class FacebookLoginWeb {
  static const MethodChannel _channel =
      const MethodChannel(//'com.roughike/flutter_facebook_login');
          'flutter_facebook_login_web');

  Future<FacebookLoginResult> logIn(List<String> permissions) async {
    var map = await _channel.invokeMethod('login', {
      'permissions': permissions,
    });

    return FacebookLoginResult._(map);
  }

  Future testApi() async {
    return await _channel.invokeMethod('testApi');
  }

  Future logOut() async {
    return await _channel.invokeMethod('logout');
  }
}

/// The result when the Facebook login flow has completed.
///
/// The login methods always return an instance of this class, whether the
/// user logged in, cancelled or the login resulted in an error. To handle
/// the different possible scenarios, first see what the [status] is.
///
/// To see a comprehensive example on how to handle the different login
/// results, see the [FacebookLogin] class-level documentation.
class FacebookLoginResult {
  /// The status after a Facebook login flow has completed.
  ///
  /// This affects the [accessToken] and [errorMessage] variables and whether
  /// they're available or not. If the user cancelled the login flow, both
  /// [accessToken] and [errorMessage] are null.
  final FacebookLoginStatus status;

  /// The access token for using the Facebook APIs, obtained after the user has
  /// successfully logged in.
  ///
  /// Only available when the [status] equals [FacebookLoginStatus.loggedIn],
  /// otherwise null.
  final FacebookAccessToken accessToken;

  /// The error message when the log in flow completed with an error.
  ///
  /// Only available when the [status] equals [FacebookLoginStatus.error],
  /// otherwise null.
  final String errorMessage;

  FacebookLoginResult._(Map<String, dynamic> map)
      : status = _parseStatus(map['status']),
        accessToken = map['accessToken'] != null
            ? FacebookAccessToken.fromMap(
                map['accessToken'].cast<String, dynamic>(),
              )
            : null,
        errorMessage = map['errorMessage'] ?? '';

  static FacebookLoginStatus _parseStatus(String status) {
    switch (status) {
      case 'connected':
        return FacebookLoginStatus.loggedIn;
      case 'unknown':
        return FacebookLoginStatus.cancelledByUser;
      case 'error':
        return FacebookLoginStatus.error;
    }

    throw StateError('Invalid status: $status');
  }
}

/// The status after a Facebook login flow has completed.
enum FacebookLoginStatus {
  /// The login was successful and the user is now logged in.
  loggedIn,

  /// The user cancelled the login flow, usually by closing the Facebook
  /// login dialog.
  cancelledByUser,

  /// The Facebook login completed with an error and the user couldn't log
  /// in for some reason.
  error,
}

/// The access token for using Facebook APIs.
///
/// Includes the token itself, along with useful metadata about it, such as the
/// associated user id, expiration date and permissions that the token contains.
class FacebookAccessToken {
  /// The access token returned by the Facebook login, which can be used to
  /// access Facebook APIs.
  final String token;

  /// The id for the user that is associated with this access token.
  final String userId;

  /// The date when this access token expires.
  final DateTime expires;

  /// The list of accepted permissions associated with this access token.
  ///
  /// These are the permissions that were requested with last login, and which
  /// the user approved. If permissions have changed since the last login, this
  /// list might be outdated.
  final List<String> permissions;

  /// The list of declined permissions associated with this access token.
  ///
  /// These are the permissions that were requested, but the user didn't
  /// approve. Similarly to [permissions], this list might be outdated if these
  /// permissions have changed since the last login.
  final List<String> declinedPermissions;

  /// Is this access token expired or not?
  ///
  /// If the access token has not been expired yet, returns true. Otherwise,
  /// returns false.
  bool isValid() => Clock.now().isBefore(expires);

  /// Constructs a access token instance from a [Map].
  ///
  /// This is used mostly internally by this library.
  FacebookAccessToken.fromMap(Map<String, dynamic> map)
      : token = map['token'],
        userId = map['userId'],
        expires = DateTime.fromMillisecondsSinceEpoch(
          map['expires'],
          isUtc: true,
        ),
        permissions = [], //map['permissions'].cast<String>(),
        declinedPermissions = []; //map['declinedPermissions'].cast<String>();

  /// Transforms this access token to a [Map].
  ///
  /// This is used mostly internally by this library.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expires': expires.millisecondsSinceEpoch,
      'permissions': permissions,
      'declinedPermissions': declinedPermissions,
    };
  }
}
