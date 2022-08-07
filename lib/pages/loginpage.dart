import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form1/core/localdisk.repo.dart/disk.repo.dart';
import 'package:form1/main.dart';
import 'package:form1/router/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/counter/counter_cubit.dart';
import 'dashboard.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      title: 'Demo Form',
      home: const LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _FormhomeState();
}

final _passwordlogin = TextEditingController();
final _emaillogin = TextEditingController();

class _FormhomeState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  checkkey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('statuscode')) {
      prefs.remove('statuscode');
    }
    if (prefs.containsKey('jwt')) {
      context.router.push(const DashboardRoute());
    }
  }


  void clear() {
    _emaillogin.clear();
    _passwordlogin.clear();
  }

  @override
  void initState() {
    super.initState;
    checkkey();
  }

  void _onLoading() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.all(8),
            child: const LinearProgressIndicator(
              backgroundColor: Colors.orangeAccent,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ));
      },
    );
    await context
        .read<CounterCubit>()
        .LoginData(_emaillogin.text, _passwordlogin.text);
    getdata();
    Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
  }

  getdata() async {
    int status = await DiskRepo().retrieve2();
    if (status == 200) {
      context.read<CounterCubit>().showToast2();
      context.router.push(const DashboardRoute());
    } else {
      context.read<CounterCubit>().showToast1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.yellow])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(255, 95, 27, 3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: [
                                  Form(
                                    key: _formkey,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey))),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Email is required';
                                              }
                                              if (!RegExp(
                                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                                  .hasMatch(value)) {
                                                return "Please Enter a Valid Email Address";
                                              }
                                            },
                                            controller: _emaillogin,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Email or Phone Number",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey))),
                                          child: TextFormField(
                                            obscureText: true,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Password is required';
                                              }
                                            },
                                            controller: _passwordlogin,
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                border: InputBorder.none),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Forget Password?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 130,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.orange[900],
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                TextButton(
                                    onPressed: (() async {
                                      if (_formkey.currentState!.validate()) {
                                        _onLoading();
                                        log(_emaillogin.text);
                                        log(_passwordlogin.text);
                                      } else {
                                        print('INVALID USERNAME OR PASSWORD');
                                      }
                                    }),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              loginstatus,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.redAccent[700]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.orange[900],
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                TextButton(
                                    onPressed: () => {
                                          {
                                            context.router
                                                .push(const RegisterRoute())
                                          }
                                        },
                                    child: const Text(
                                      "New Registration",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                                const SizedBox(
                                  height: 250,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
