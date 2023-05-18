import 'package:employees_book/SHAREDPREFERENCE/sharedPreffenceData.dart';
import 'package:employees_book/WIDGETS/appButton.dart';
import 'package:employees_book/WIDGETS/appText.dart';
import 'package:employees_book/WIDGETS/appTextField.dart';
import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userControll = TextEditingController();
  TextEditingController passwordControll = TextEditingController();

  void userLogin() async {
    final username = userControll.text.trim();
    final password = passwordControll.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.statusCode == 200) {
      setVisitingFlag();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: messageText(labelText: "Successfully Login"),
          duration: Duration(seconds: 3),
        ));
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/homeScreen');
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: messageText(labelText: response.error.toString()),
          duration: Duration(seconds: 3),
        ));
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: defaultPadding),
            SizedBox(
              width: widgetSize.width / 2,
              child: Image.asset("assets/images/splash_logo.png"),
            ),
            mainTextFiled(
              controllerText: userControll,
              perfixIcon: Icons.person,
              hintText: 'User Name',
              obsecure: false,
            ),
            mainTextFiled(
              controllerText: passwordControll,
              perfixIcon: Icons.lock,
              hintText: 'Password',
              obsecure: true,
            ),
            const SizedBox(height: defaultPadding),
            mainButton(
              context: context,
              buttonAction: () {
                setState(() {
                  loading = true;
                });
                userLogin();
              },
              buttonText: loading == true ? "Loading..." : "LOGIN",
            ),
          ],
        ),
      ),
    );
  }
}
