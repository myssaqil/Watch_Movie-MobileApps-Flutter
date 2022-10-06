import 'package:flutter/material.dart';
import 'package:watchm_app/LoginPage/login.dart';
import 'package:watchm_app/LoginPage/register.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Image.asset(
              'Image/Logo.png',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text("Explore various movies now!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistForm(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0)),
                          elevation: 0),
                      child: const Text('Register')),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginForm(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(0, 255, 255, 255),
                            side: BorderSide(color: Colors.white),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(7.0)),
                            elevation: 0),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
