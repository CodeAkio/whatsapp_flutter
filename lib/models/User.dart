// ignore_for_file: file_names

class UserModel {
  String? _name;
  String? _email;
  String? _password;

  UserModel();

  String get name => _name!;

  set name(String value) {
    _name = value;
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }
}
