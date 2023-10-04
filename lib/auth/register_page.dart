import 'package:fitchat/auth/login_page.dart';
import 'package:fitchat/helper/helper_function.dart';
import 'package:fitchat/pages/home_page.dart';
import 'package:fitchat/services/auth_service.dart';
import 'package:fitchat/widget/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _isloading = false;
  AuthService authService = AuthService();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  String fullName = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          "FitHub",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Empower Your Journey: Join the Fitness Revolution!"),
                        Image.asset("assets/register.png"),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _usernamecontroller,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Usrname"),
                          onChanged: (value) {
                            fullName = value;
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return "Usranme cannot be empty";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: _emailcontroller,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter a valid email";
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Password"),
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value!.length < 6) {
                              return "password should be greater than 6 charachters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              child: Text("SignUp"),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text.rich(TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "LogIn!",
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextScreen(context, LoginPage());
                                    })
                            ]))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserNameSF(fullName);
          nextScreenReplacement(context, HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isloading = false;
          });
        }
      });
    }
  }
}
