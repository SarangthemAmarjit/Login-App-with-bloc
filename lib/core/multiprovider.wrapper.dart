import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form1/core/localdisk.repo.dart/disk.repo.dart';
import 'package:form1/logic/counter/counter_cubit.dart';
import 'package:form1/repository/resgitration.repo.dart';

class MultiproviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiproviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CounterCubit(
            repo: context.read<ResgitrationRepo>(),
            diskrepo: context.read<DiskRepo>()),
      ),
    ], child: child);
  }
}
