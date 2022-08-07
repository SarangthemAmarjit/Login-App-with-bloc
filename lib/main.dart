import 'package:flutter/material.dart';
import 'package:form1/core/multiprovider.wrapper.dart';
import 'package:form1/core/multirepository.wrapper.dart';
import 'package:form1/router/router.gr.dart';

String loginstatus = '';
void main() {
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultirepositoryWrapper(
        child: MultiproviderWrapper(
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Strapi log in App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    ));
  }
}

class StrapiLogin extends StatefulWidget {
  const StrapiLogin({Key? key}) : super(key: key);

  @override
  State<StrapiLogin> createState() => _StrapiLoginState();
}

class _StrapiLoginState extends State<StrapiLogin> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
