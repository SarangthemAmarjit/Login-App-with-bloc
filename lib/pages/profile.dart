import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form1/Refactor/inputfield.dart';
import 'package:form1/Refactor/profilelist.dart';
import 'package:form1/core/localdisk.repo.dart/disk.repo.dart';
import 'package:form1/logic/counter/counter_cubit.dart';
import 'package:form1/modals/getmodal.dart';
import 'package:form1/pages/profilephoto.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Form profileform = Form(child: Column());
  var format = DateFormat("yyyy-MM-dd");
  Container profiledata = Container();
  String userna = '';

  DateTime? birthDate;
  int id = 0;
  @override
  void initState() {
    super.initState();
    getid();
    getuser();
  }

  getuser() async {
    var data = await context.read<CounterCubit>().diskrepo.retrieve1();
    setState(() {
      userna = data;
      print(userna);
    });
  }

  getid() async {
    var data = await context.read<CounterCubit>().diskrepo.retrieve3();
    setState(() {
      id = data;
      log(id.toString());
    });
  }

  final TextEditingController _numbercontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _postofficecontroller = TextEditingController();
  final TextEditingController _policestationcontroller =
      TextEditingController();
  final TextEditingController _districtcontroller = TextEditingController();
  final TextEditingController _pincodecontroller = TextEditingController();

  Widget _buildAge() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("Date of Birth ",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 42, bottom: 10),
            child: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) async {
                birthDate = await showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2025),
                    helpText: "SELECT DATE OF BIRTH",
                    cancelText: "CANCEL",
                    confirmText: "OK",
                    fieldHintText: "DATE/MONTH/YEAR",
                    fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                    errorFormatText: "Enter a Valid Date",
                    errorInvalidText: "Date Out of Range");

                return birthDate;
              },
            ),
          ),
        ]);
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
    String convertedDate = DateFormat("yyyy-MM-dd").format(birthDate!);
    await context.read<CounterCubit>().updateprofile(
        id: id,
        number: _numbercontroller.text,
        address: _addresscontroller.text,
        postoffice: _postofficecontroller.text,
        dateofbirth: convertedDate,
        district: _districtcontroller.text,
        policestation: _policestationcontroller.text,
        pincode: _pincodecontroller.text);
    getdata1();
    Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  getdata1() async {
    int status = await DiskRepo().retrieve4();
    if (status == 200) {
      context.read<CounterCubit>().showToast4();
    } else if (status == 500) {
      context.read<CounterCubit>().showToast31();
    } else {
      context.read<CounterCubit>().showToast3();
    }
  }

  Getdata? finaldata;
  void _onLoading2() async {
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
    finaldata = await context.read<CounterCubit>().getProfile();
    getdata2();
    Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
  }

  getdata2() async {
    int status = await DiskRepo().retrieve5();
    String finaldate =
        DateFormat("yyyy-MM-dd").format(finaldata!.data.attributes.dateOfBirth);
    if (status == 200) {
      setState(() {
        profiledata = Container(
          child: Column(
            children: [
              Container(
                child: const CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  'NAME :' + userna,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              ProfileUpdate(
                  text1: 'PHONE NUMBER :',
                  text2: finaldata!.data.attributes.number),
              ProfileUpdate(
                  text1: 'ADDRESS :',
                  text2: finaldata!.data.attributes.address),
              ProfileUpdate(
                  text1: 'POST OFFICE :',
                  text2: finaldata!.data.attributes.postOffice),
              ProfileUpdate(
                  text1: 'POLICE STATION :',
                  text2: finaldata!.data.attributes.policeStation),
              ProfileUpdate(
                  text1: 'DISTRICT :',
                  text2: finaldata!.data.attributes.district),
              ProfileUpdate(
                  text1: 'PIN CODE :',
                  text2: finaldata!.data.attributes.pincode),
              ProfileUpdate(text1: 'DATE OF BIRTH :', text2: finaldate),
            ],
          ),
        );
      });
    } else {
      context.read<CounterCubit>().showToast2();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (cnt) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: AlertDialog(
                              content: Form(
                                child: Container(
                                  width: MediaQuery.of(cnt).size.width,
                                  child: Column(
                                    children: [
                                      Document1(),
                                      ProfileField(
                                        label: 'Phone number',
                                        controller: _numbercontroller,
                                      ),
                                      ProfileField(
                                        label: 'Address',
                                        controller: _addresscontroller,
                                      ),
                                      _buildAge(),
                                      ProfileField(
                                        label: 'Post Office',
                                        controller: _postofficecontroller,
                                      ),
                                      ProfileField(
                                        label: 'Police Station',
                                        controller: _policestationcontroller,
                                      ),
                                      ProfileField(
                                        label: 'District',
                                        controller: _districtcontroller,
                                      ),
                                      ProfileField(
                                        label: 'Pin Code',
                                        controller: _pincodecontroller,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () {
                                          Navigator.pop(cnt);
                                        },
                                        child: const Text("CANCEL")),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          onPressed: () async {
                                            _onLoading();
                                          },
                                          child: Text("SAVE")),
                                    )
                                  ],
                                ),
                              ],
                              title: const Text("UPDATE PROFILE"),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Update Profile')),
                ElevatedButton(
                    onPressed: () {
                      _onLoading2();
                    },
                    child: const Text('Show Profile')),
              ],
            ),
            profiledata
          ],
        ),
      ),
    );
  }
}
