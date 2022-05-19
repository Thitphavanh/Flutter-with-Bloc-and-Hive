import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;

  User(this.username, this.password);
}
