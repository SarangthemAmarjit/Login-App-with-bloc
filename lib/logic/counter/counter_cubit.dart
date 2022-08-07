import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form1/modals/getmodal.dart';
import 'package:form1/modals/jwt_model.dart';
import 'package:form1/modals/postmodel.dart';
import '../../core/localdisk.repo.dart/disk.repo.dart';
import '../../repository/resgitration.repo.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit({required this.diskrepo, required this.repo})
      : super(const CounterState(
            finalkey1: '', finalkey2: '', getuser: '', getstatuscode: 0));

  int? loginresponse;
  final ResgitrationRepo repo;
  final DiskRepo diskrepo;
  String getkey1 = '';
  String getkey2 = '';
  String getuserfinal = '';
  String getname = '';
  int getstatuscode = 0;

  submitData(
    String username,
    String email,
    String password,
  ) async {
    JwtModel? regmodel = await repo.registration(
        username: username, email: email, password: password);
    getkey1 = regmodel!.jwt;

    getuserfinal = regmodel.user.username;

    emit(CounterState(
        finalkey1: getkey1,
        finalkey2: getkey2,
        getuser: getuserfinal,
        getstatuscode: ResgitrationRepo().getstatus));
  }

  LoginData(
    String email,
    String password,
  ) async {
    JwtModel? logmodel = await repo.login(email: email, password: password);
    if (logmodel == null) {
      int status = await diskrepo.retrieve2();
    } else {
      getkey2 = logmodel.jwt;
      getuserfinal = logmodel.user.username;
      emit(CounterState(
          finalkey1: getkey1,
          finalkey2: getkey2,
          getuser: getuserfinal,
          getstatuscode: 0));
    }
  }

  updateprofile(
      {required int id,
      required String number,
      required String address,
      required String postoffice,
      required String dateofbirth,
      required String district,
      required String policestation,
      required String pincode}) async {
    Postmodel? logmodel = await repo.creatprofile(
        id: id,
        number: number,
        address: address,
        postoffice: postoffice,
        dateofbirth: dateofbirth,
        district: district,
        policestation: policestation,
        pincode: pincode);
    if (logmodel == null) {
      int status = await diskrepo.retrieve4();
    } else {
      emit(CounterState(
          finalkey1: getkey1,
          finalkey2: getkey2,
          getuser: getuserfinal,
          getstatuscode: 0));
    }
  }

  getProfile() async {
    Getdata? getmodel = await repo.Getprofile();
    if (getmodel == null) {
      int status = await diskrepo.retrieve5();
    } else {
      return getmodel;
    }
  }

  void showToast1() {
    Fluttertoast.showToast(
        msg: 'INVALID USERNAME OR PASSWORD',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showToast3() {
    Fluttertoast.showToast(
        msg: 'CANNOT UPDATE PROFILE CHECK YOUR DETAILS',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showToast31() {
    Fluttertoast.showToast(
        msg: 'PROFILE ALREADY UPDATED CLICK SHOW PROFILE',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showToast_reg1() {
    Fluttertoast.showToast(
        msg: 'REGISTRATION COMPLETED',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showToast_reg2() {
    Fluttertoast.showToast(
        msg: 'REGISTRATION FAILED',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  void showToast2() {
    Fluttertoast.showToast(
        msg: 'SUCCESSFULLY LOGIN',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 247, 15, 73),
        textColor: const Color.fromARGB(255, 253, 255, 254));
  }

  void showToast4() {
    Fluttertoast.showToast(
        msg: 'SUCCESSFULLY UPDATED PROFILES',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Color.fromARGB(255, 247, 15, 73),
        textColor: const Color.fromARGB(255, 253, 255, 254));
  }
}
