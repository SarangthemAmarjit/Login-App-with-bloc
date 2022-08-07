import 'dart:convert';
import 'dart:developer';
import 'package:form1/core/localdisk.repo.dart/disk.repo.dart';
import 'package:form1/modals/getmodal.dart';
import 'package:form1/modals/postmodel.dart';
import 'package:http/http.dart' as http;

import '../modals/jwt_model.dart';

class ResgitrationRepo {
  int getstatus = 0;

  Future<JwtModel?> registration(
      {required String username,
      required String email,
      required String password}) async {
    var body = {"username": username, "email": email, "password": password};
    final response = await http.post(
        Uri.parse('https://herokunew123.herokuapp.com/api/auth/local/register'),
        body: body);
    var data = jsonDecode(response.body);
    print(data);
    getstatus = response.statusCode;

    if (getstatus == 200) {
      JwtModel finalmodel = JwtModel.fromJson(data);
      DiskRepo().save(
          savekey1: finalmodel.jwt,
          savekey2: '',
          getusername: finalmodel.user.username,
          getcode: getstatus,
          id: finalmodel.user.id);
      return finalmodel;
    } else {}
  }

  Future<JwtModel?> login(
      {required String email, required String password}) async {
    var body = {"identifier": email, "password": password};

    final response = await http.post(
        Uri.parse('https://herokunew123.herokuapp.com/api/auth/local'),
        body: body);
    var data = jsonDecode(response.body);
    getstatus = response.statusCode;
    if (getstatus == 200) {
      JwtModel finalmodel2 = JwtModel.fromJson(data);
      print(finalmodel2);

      DiskRepo().save(
          savekey1: '',
          savekey2: finalmodel2.jwt,
          getusername: finalmodel2.user.username,
          getcode: getstatus,
          id: finalmodel2.user.id);
      return finalmodel2;
    } else {
      DiskRepo().save2(getcode: getstatus);
    }
  }

  Future<Postmodel?> creatprofile(
      {required int id,
      required String number,
      required String address,
      required String postoffice,
      required String dateofbirth,
      required String district,
      required String policestation,
      required String pincode}) async {
    var body = {
      "data": {
        "id": id,
        "number": number,
        "address": address,
        "post_office": postoffice,
        "district": district,
        "police_station": policestation,
        "pincode": pincode,
        "date_of_birth": dateofbirth
      }
    };
    final response = await http.post(
      Uri.parse('https://herokunew123.herokuapp.com/api/profiles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Postmodel finalmodel3 = Postmodel.fromJson(jsonDecode(response.body));

      DiskRepo().save3(getcode: response.statusCode);
      log('Successfully Create Profile');
      return finalmodel3;
    } else {
      DiskRepo().save3(getcode: response.statusCode);
      log('Failed to Create Profile.');
    }
  }

  Future<Getdata?> Getprofile() async {
    int id = await DiskRepo().retrieve3();
    final response = await http
        .get(Uri.parse('https://herokunew123.herokuapp.com/api/profiles/$id'));

    if (response.statusCode == 200) {
      Getdata data = Getdata.fromJson(jsonDecode(response.body));
      DiskRepo().save4(getcode: response.statusCode);
      log('Successfully Shown Profile');
      return data;
    } else {
      DiskRepo().save4(getcode: response.statusCode);
      log('Failed to Getdata.');
    }
  }
}
