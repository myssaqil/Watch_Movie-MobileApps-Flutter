import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchm_app/Homepage/Explorepage.dart';
import 'package:watchm_app/LoginPage/register.dart';
import 'package:watchm_app/authen/authentication.dart';
import 'package:watchm_app/navbotbar.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onTap: (() {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "Email",
                          labelStyle: new TextStyle(color: Colors.white)),
                      onSaved: (val) {
                        email = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: _isObscure,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelStyle: new TextStyle(color: Colors.white),
                          labelText: "Password",
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        password = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => activitymain(),
                            ));
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200, bottom: 20),
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        AuthenticationHelper()
                            .signIn(email: email!, password: password!)
                            .then((ok) {
                          if (ok == null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => activitymain()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                ok,
                                style: TextStyle(fontSize: 16),
                              ),
                            ));
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(7.0)),
                        elevation: 0),
                    child: const Text('LOGIN')),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistForm(),
                          ));
                    },
                    child: Text(
                      " Register Now",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
