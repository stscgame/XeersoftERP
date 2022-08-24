import 'package:flutter/material.dart';
import 'package:xeersoft_erp/page/home.dart';
import 'package:xeersoft_erp/service/api_service.dart';
import 'page/login.dart';

import 'package:xeersoft_erp/model/user_data.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: LanchPage(),
  ));
}

class LanchPage extends StatelessWidget {
  const LanchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final readData = readLocalData();
   readData.then((token) {
     if (token != "") {
       final autoLoginHandle = autoLogin(token, "");
       autoLoginHandle.then((user) {
         // ignore: unnecessary_null_comparison
         if (user.userId != null) {
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
               builder: (BuildContext context) => HomePage(user: user,),
             ),
             (route) => false,
           );
         }else {
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
               builder: (BuildContext context) => const LoginPage(),
             ),
             (route) => false,
           );
         }
       });
     } else {
       Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder: (BuildContext context) =>  const LoginPage(),
         ),
         (route) => false,
       );
     }
   }).catchError((error) {
     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder: (BuildContext context) => const LoginPage(),
         ),
         (route) => false,
       );
   });

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center),
    );
  }
}
