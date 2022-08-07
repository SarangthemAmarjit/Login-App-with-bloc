import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileUpdate extends StatelessWidget {
  final String text1;
  final String text2;
  const ProfileUpdate({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      child: ListTile(
          shape: RoundedRectangleBorder(
              // side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          tileColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                text2,
                style: const TextStyle(color: Color.fromARGB(255, 18, 102, 7)),
              ),
            ],
          )),
    );
  }
}
