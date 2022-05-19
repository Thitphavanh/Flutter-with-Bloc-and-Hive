import 'package:flutter_with_bloc_and_hive/model/user.dart';
import 'package:hive/hive.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');

    await _users.clear();

    await _users.add(User('testuser1', 'password'));
    await _users.add(User('flutterfromscratch', 'password'));
  }

  Future<String?> authenticateUser(
      final String username, final String password) async {
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
