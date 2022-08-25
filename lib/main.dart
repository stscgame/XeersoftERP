import 'package:flutter/material.dart';
import 'package:xeersoft_erp/login/page/home.dart';
import 'package:xeersoft_erp/login/service/login_service.dart';
import 'login/page/login.dart';
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
   UserLogin().readLocalData().then((token) {
     if (token != "") {
       final autoLoginHandle = UserLogin().autoLogin(token, "");
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
