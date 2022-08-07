import 'package:auto_route/auto_route.dart';
import 'package:form1/pages/dashboard.dart';
import 'package:form1/pages/loginpage.dart';
import 'package:form1/pages/profile.dart';
import 'package:form1/pages/registerpage.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: DashboardPage),
    AutoRoute(page: ProfilePage),
  ],
)
class $AppRouter {}

