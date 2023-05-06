import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_dojah_financial/flutter_dojah_financial.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Map<dynamic, dynamic> envVars = Platform.environment;

class _HomePageState extends State<HomePage> {
// final appId= envVars['appId']; //your application ID
// final publicKey = envVars['publicKey']; //your public key

  final appId = "6453dd67c9f31e0034f1c5f6"; //your application ID
  final publicKey = "test_pk_VEQd77dXDM61vEURsJdErLxcV"; //your public key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dojah Widget"),
          //backgroundColor: Colors.yellow,
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            child: TextButton(
              child: const Text(
                'Custom Widget',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                final userData = {
                  "first_name": "Michael",
                  "last_name": "Folayan",
                  "dob": "1998-05-16",
                  "residence_country": "Nigeria"
                };

                final configObj = {
                  "debug": true,
                  "mobile": true,
                  "otp": true,
                  "selfie": true,
                  // "aml": false,
                  "webhook": true,
                  "review_process": "Automatic",
                  "pages": [
                    // { "page": "phone-number", "config": { "verification": true } },
                    {
                      "page": "government-data",
                      "config": {
                        "bvn": true,
                        "nin": false,
                        "dl": false,
                        "mobile": false,
                        "otp": true,
                        "selfie": false
                      }
                    },

                    //{ "page": "user-data", "config": { "enabled": false } },
                    //{ "page": "countries", "config": { "enabled": false } },

                    // { "page": "business-data", "config": {"cac": true, "tin": true, "verification": true} },
                    // { "page": "business-id" },

                    {
                      "page": "selfie",
                      "config": {"verification": true}
                    },

                    // {"page": "address"},
                    {
                      "page": 'id',
                      "config": {
                        "passport": true,
                        "dl": true,
                        "nin": true,
                        "voter": true,
                      }
                    },
                  ]
                };

                final metaData = {
                  "user_id": "81828289191919193882",
                };

                const referenceId = "123456789012a";

                DojahFinancial? _dojahKYC;

                ///Use your appId and publicKey
                _dojahKYC = DojahFinancial(
                  appId: appId,
                  publicKey: publicKey,
                  type: "custom",
                  userData: userData,
                  metaData: metaData,
                  config: configObj,
                  // referenceId: referenceId
                );

                print(json.encode(configObj));
                print(json.encode(configObj));
                //print(userData);
                print(configObj);
                _dojahKYC.open(context,
                    onSuccess: (result) => print(result),
                    onClose: (close) => print('Widget Closed'),
                    onError: (error) => print(error));
              },
            ),
          ),
        ])));
  }
}
