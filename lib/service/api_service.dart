
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xeersoft_erp/model/user_data.dart';

Future<UserData> doLogin(username, password) async {
  final client = http.Client();
  try {
    final response = await client.post(
        Uri.https('self-u-api-dev.xeersoft.co.th', '/api/login/v2'),
        body: {'username': username, 'password': password});
    final decodedResponse = UserData.fromJson(jsonDecode(response.body));
    print('Response status: ${response.statusCode}');
    print('Response is: ${decodedResponse}');
    if (response.statusCode == 200) {
      return decodedResponse;
    } else {
      throw Exception('Failed to login');
    }
  } finally {
    client.close();
  }
}

Future<UserData> autoLogin(String accessToken,String refreshToken) async{
final client = http.Client();
  try {
    final response = await client.post(
        Uri.https('self-u-api-dev.xeersoft.co.th', '/token/authenticate'),
        body: {'accessToken': accessToken, 'refreshToken': refreshToken}).catchError((err) {
          print(err);
        });
    final decodedResponse = UserData.fromJson(jsonDecode(response.body));
    // print('Response status: ${response.statusCode}');
    // print('Response is: ${decodedResponse}');
      
    if (response.statusCode == 200) {
      if (decodedResponse.accessToken != "") {
         saveToLocalData(decodedResponse.accessToken);
      }else {
        saveToLocalData(accessToken);
      }
      return decodedResponse;
    } 
    else {
      throw Exception('Failed to login');
    }
  } finally {
    client.close();
  }
}