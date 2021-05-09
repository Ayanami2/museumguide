import 'package:museumguide/models/index.dart';
import 'package:museumguide/config/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static Future<bool> isUserExist({
    String searchedIDNumber,
  }) async {
    final response = await http.post(
      ServerUrl.USER_URL,
      body: {
        "action": "isUserExist",
        "IDNumber": searchedIDNumber,

      },
    );
    print(response.body);
    if (response.body == "true") {
      return true;
    } else {
      return false;
    }
  }
  static Future<User> getUserByAccountNumber({
    num accountNumber,
  }) async {
    final response = await http.post(
      ServerUrl.USER_URL,
      body: {
        "action": "getUserByAccountNumber",
        "accountNumber": accountNumber.toString(),
      },
    );
    // print(MuseumBasicInformation.fromJson(jsonDecode(response.body)).museumID);
    return User.fromJson(jsonDecode(response.body));
  }

  static void insertUser({
    User insertedUser,
  }) async {
    print(insertedUser.IDNumber);
    final response = await http.post(
      ServerUrl.USER_URL,
      body: {
        "action": "insertUser",
        "nickName": insertedUser.nickName ?? "none",
        "IDNumber": insertedUser.IDNumber,
        "name": insertedUser.name ?? "none",
        "permission": insertedUser.permission ?? 0.toString(),
        "accountNumber": insertedUser.accountNumber.toString(),
        "password": insertedUser.password ?? "none",
        "phoneNumber": insertedUser.phoneNumber ?? "none",
        "email": insertedUser.email ?? "none",
        "state": insertedUser.state ?? 1.toString(),
      },
    );
    print(response.body);
  }

  static void updatePassword({
    int accountNumber,
    String password,
  }) async {
    final response = await http.post(
      ServerUrl.USER_URL,
      body: {
        "action": "updatePassword",
        "accountNumber": accountNumber.toString(),
        "password": password,
      },
    );
    print(response.body);
  }
}
