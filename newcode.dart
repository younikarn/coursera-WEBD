import 'package:flutter/material.dart';
import 'package:flash_chat/components/buttons.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class UserDetails extends StatefulWidget {
  final String phone;
  UserDetails({this.phone});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _auth = FirebaseAuth.instance;
  User user;
  bool nameerror = false, addresserror = false;
  var namecontroller = TextEditingController();

  String username, useraddress;
  String buttonname = 'x1';

  void updateuserprofile(String name, String address) async {
    user = _auth.currentUser;
    user.updateProfile(displayName: name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: TextField(
              controller: namecontroller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                // print(value);
                setState(() {
                  nameerror = false;
                });
                // if (value == null) {
                //   namecontroller.clear();
                //   print('value null');
                // } else {
                debugPrint(value);
                log(value);
                username = value;
                // }
                //Do something with the user input.
              },
              decoration: kinputdecoration.copyWith(
                hintText: "Enter The Name",
                errorText: nameerror ? 'Enter the name' : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.streetAddress,
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                useraddress = value;

                //Do something with the user input.
              },
              decoration: kinputdecoration.copyWith(
                  hintText: "Enter The Address",
                  errorText: addresserror ? 'Enter the address' : null),
            ),
          ),
          Buttons(
            name: "hello",
            onpress: () {
              log(username);
              setState(() {
                buttonname = 'x1';
              });

              if (username == null) {
                setState(() {
                  nameerror = true;
                });
              } else if (useraddress == null) {
                setState(() {
                  addresserror = true;
                });
              } else {
                Navigator.pushNamed(context, 'mainscreen');
              }
            },
          )
        ],
      ),
    );
  }
}
