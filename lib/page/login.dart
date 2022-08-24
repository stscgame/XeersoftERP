// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:xeersoft_erp/page/home.dart';
import 'package:xeersoft_erp/service/api_service.dart';
import 'package:xeersoft_erp/widgets/dialog_custom.dart';
import 'package:xeersoft_erp/model/user_data.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "XEERSOFT ERP",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 60,
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: const InputDecoration(hintText: "Password"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  onPressed: () {
                      final checkUserIsNull = checkTextFiledUser(
                      emailController.text, passController.text);
                  checkUserIsNull.then((statusCheckFiled) {
                    if (statusCheckFiled == true) {
                      final dataUser = doLogin(
                          emailController.text, passController.text);
                      dataUser.then((user) {
                        saveToLocalData(user.accessToken);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(
                              user: user
                            ),
                          ),
                          (route) => false,
                        );
                      }).catchError((error) {
                        showAlertDialog(context, "Login Fail", "");
                      });
                    }
                  });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FlatButton(
                child: const Text('Forgot password'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> checkTextFiledUser(username, password) async {
  if (username != "" && password != "") {
    return true;
  } else {
    return false;
  }
}
