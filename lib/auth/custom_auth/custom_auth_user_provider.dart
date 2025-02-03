import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class DupnoGPSProAuthUser {
  DupnoGPSProAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<DupnoGPSProAuthUser> dupnoGPSProAuthUserSubject =
    BehaviorSubject.seeded(DupnoGPSProAuthUser(loggedIn: false));
Stream<DupnoGPSProAuthUser> dupnoGPSProAuthUserStream() =>
    dupnoGPSProAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
