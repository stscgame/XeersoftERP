// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:xeersoft_erp/login/page/home.dart';
import 'package:xeersoft_erp/login/service/login_service.dart';
import 'package:xeersoft_erp/login/widgets/dialog_custom.dart';
// import 'package:xeersoft_erp/login/model/user_data.dart';
import 'package:flutter/services.dart' show rootBundle;

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
    var assetsImage = const AssetImage(
        'assets/images/ERPicon.png'); //<- Creates an object that fetches an image.
    var image = Image(image: assetsImage, fit: BoxFit.cover);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image,
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
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'USERNAME',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'PASSWORD',
                          ),
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
                  color: Colors.black,
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
                        UserLogin()
                            .doLogin(emailController.text, passController.text)
                            .then((user) {
                          UserLogin().saveToLocalData(user.accessToken);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(user: user),
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
                child: const Text('FORGOT PASSWORD?Click'),
                onPressed: () {},
              ),
              const Text(
                "Version 1.0",
                style: TextStyle(fontSize: 12),
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
