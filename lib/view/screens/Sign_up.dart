import 'package:author_registration_app/helper/firebase_auth_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  final signUpFormKey = GlobalKey<FormState>();
  TextEditingController EmailControllar = TextEditingController();
  TextEditingController PasswordControllar = TextEditingController();
  var email;
  var pass;

  void ValidEmail() {
    final bool isvalid = EmailValidator.validate(EmailControllar.text.trim());

    if (isvalid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Valid Email")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Not a Valid Email")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment(0, -0.8),
              children: [
                Container(
                  height: 430,
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: signUpFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Container(
                            height: 50,
                            child: TextFormField(
                              controller: EmailControllar,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter user Name...';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                email = val;
                              },
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.person_outline_rounded,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "Email/Mobile",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: "verdana_regular",
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: 'Email/Mobile',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter password...';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                pass = val;
                              },
                              controller: PasswordControllar,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: "verdana_regular",
                                  fontWeight: FontWeight.w400,
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38, //New
                        blurRadius: 10,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  child: FlutterLogo(size: 50),
                ),
                Positioned(
                  top: 320,
                  left: 100,
                  child: GestureDetector(
                    onTap: () async {
                      ValidEmail();
                      if (signUpFormKey.currentState!.validate()) {
                        signUpFormKey.currentState!.save();
                        User? user =
                            await firebaseAuthhelper.FirebaseAuthhelper.signUp(
                                email: EmailControllar.text,
                                password: PasswordControllar.text);

                        if (User != Null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign Up succcess..."),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.of(context).pushReplacementNamed('/');
                        } else {
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign Up Failad..."),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(255, 109, 182, 112)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'Login');
                },
                child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  Map<String, dynamic> res = await firebaseAuthhelper
                      .FirebaseAuthhelper.signInWithGoogle();
                  if (res['user'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login successful..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Faild"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.g_mobiledata_rounded),
                label: Text("Google"),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 146, 180, 230),
    );
  }
}
