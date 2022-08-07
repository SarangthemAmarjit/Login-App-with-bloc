import 'dart:convert';

Getdata getdataFromJson(String str) => Getdata.fromJson(json.decode(str));

String getdataToJson(Getdata data) => json.encode(data.toJson());

class Getdata {
  Getdata({
    required this.data,
    required this.meta,
  });

  final Data data;
  final Meta meta;

  factory Getdata.fromJson(Map<String, dynamic> json) => Getdata(
        data: Data.fromJson(json["data"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.attributes,
  });

  final int id;
  final Attributes attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    required this.number,
    required this.address,
    required this.postOffice,
    required this.district,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.policeStation,
    required this.pincode,
    required this.dateOfBirth,
  });

  final String number;
  final String address;
  final String postOffice;
  final String district;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final String policeStation;
  final String pincode;
  final DateTime dateOfBirth;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        number: json["number"],
        address: json["address"],
        postOffice: json["post_office"],
        district: json["district"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        policeStation: json["police_station"],
        pincode: json["pincode"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "address": address,
        "post_office": postOffice,
        "district": district,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "police_station": policeStation,
        "pincode": pincode,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
