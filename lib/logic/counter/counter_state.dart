part of 'counter_cubit.dart';

class CounterState extends Equatable {
  const CounterState(
      {required this.finalkey1,
      required this.finalkey2,
      required this.getuser,
      required this.getstatuscode});

  final String finalkey1;
  final String finalkey2;
  final String getuser;
  final int getstatuscode;

  @override
  List<Object> get props => [finalkey1, finalkey2, getuser, getstatuscode];
}
