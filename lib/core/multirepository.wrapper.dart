import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form1/core/localdisk.repo.dart/disk.repo.dart';
import 'package:form1/repository/resgitration.repo.dart';

class MultirepositoryWrapper extends StatelessWidget {
  final Widget child;
  const MultirepositoryWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<ResgitrationRepo>(
        create: (context) => ResgitrationRepo(),
      ),
      RepositoryProvider<DiskRepo>(
        create: (context) => DiskRepo(),
      ),
    ], child: child);
  }
}
