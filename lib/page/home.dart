import 'package:flutter/material.dart';

import 'login.dart';
import 'package:xeersoft_erp/model/user_data.dart';

class HomePage extends StatelessWidget {
  final UserData user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(user.encId),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                user.xsId,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()
                      ));
                },
                child: const Text("logout")),
          ],
        ),
        //
      ),
    );
  }

  loginPage() {}
}
