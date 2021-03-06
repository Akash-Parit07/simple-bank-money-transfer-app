import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BasicBankApp/model/cust_data.dart';
import 'package:BasicBankApp/pages/customers_details.dart';
import 'package:BasicBankApp/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

var data = <CustomerData>[
  CustomerData(101, 'Akash Parit', 'Kolhapur', 7875665705, 10000),
  CustomerData(102, 'Mark Rutherford', 'US', 77777, 6000),
  CustomerData(103, 'Tony Stark', 'US', 99999, 30000),
  CustomerData(104, 'Chris Hemsworth', 'Africa', 10100, 13279),
  CustomerData(105, 'Chris Evans', 'US', 45455, 7895),
  CustomerData(106, 'Steve Roger', 'New York', 12345, 10000),
  CustomerData(107, 'Mary Astor', 'US', 98982, 100000),
  CustomerData(108, 'Will Rogers', 'UK', 76584, 5000),
  CustomerData(109, 'John Ford', 'England', 41411, 7861),
  CustomerData(110, 'Kevin Spacey', 'US', 123789, 8000),
  CustomerData(111, 'Robert De Niro', 'London', 567894, 254700),
  CustomerData(112, 'John Jocabbsen', 'America', 9878, 40000),
  CustomerData(113, 'Karen Jocabbsen', 'US', 9595, 8000),
  CustomerData(114, 'Robert De Janro', 'London', 37377, 25700),
];

class _MyHomePage extends State<MyHomePage> {
  DatabaseHelper helper = DatabaseHelper();

  //For inserting dummy data when application is installed.
  void insertDummyData() async {
    int result;
    for (int i = 0; i < data.length; i++) {
      //print(data[i].custName);
      try {
        CustomerData tempData = new CustomerData(data[i].accountNo,
            data[i].custName, data[i].custAddr, data[i].phoneNo, data[i].bal);
        result = await helper.insertData(tempData);
        //print("Success $i");
      } catch (e) {
        //print(e + data[i]);
        message("Error while connecting to database.");
      }
    }
  }

  //Dummy data is inserted once application is installed
  _insertDummyData() async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    bool insertStatus = preferences.getBool("insertDummyData");
    if (insertStatus == null) {
      preferences.setBool("insertDummyData", false);
      return true;
    }
    return false;
  }

  //Displaying flutter toast message.
  message(String msg) {
    Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    _insertDummyData().then((status) {
      if (status) {
        insertDummyData();
      }
    });
    Timer(Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => CustomersDetails(),
      ));
    });
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 130.0,
                            width: 130.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage('assets/mobile_bank.png'),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25.0)),
                          Text(
                            'Basic Bank App',
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 35.0),
                        ),
                        Text(
                          'Developed By Akash Parit',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
