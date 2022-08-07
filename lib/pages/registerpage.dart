import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form1/Refactor/inputfield.dart';
import 'package:form1/pages/dashboard.dart';
import 'package:form1/router/router.gr.dart';
import '../logic/counter/counter_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _MyWidgetState();
}

final _usernameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

String name1 = _usernameController.text;
String email1 = _emailController.text;
String password1 = _passwordController.text;

class _MyWidgetState extends State<RegisterPage> {
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  int regstatuscode = 0;

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
    await context.read<CounterCubit>().submitData(name1, email1, password1);
    getuser();
    Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
  }

  getuser() async {
    var data = await context.read<CounterCubit>().diskrepo.retrieve2();
    setState(() {
      regstatuscode = data;
    });
    if (regstatuscode == 200) {
      context.read<CounterCubit>().showToast_reg1();
      context.router.push(const DashboardRoute());
    } else {
      context.read<CounterCubit>().showToast_reg2();
      log('Error Status Code');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<CounterCubit>();
    final d = s.state.finalkey1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Form(
                  key: _formkey2,
                  child: Column(
                    children: [
                      Namefield(
                        usercon: _usernameController,
                      ),
                      Emailfield(
                        emailcon: _emailController,
                      ),
                      PasswordField(
                        passcon: _passwordController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: (() async {
                            if (_formkey2.currentState!.validate()) {
                              _onLoading();
                            } else {
                              print('Form field cant be Empty');
                            }
                          }),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ))
                    ],
                  ))),
        ],
      ),
    );
  }
}
