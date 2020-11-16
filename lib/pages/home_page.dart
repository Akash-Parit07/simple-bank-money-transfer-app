import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/model/cust_data.dart';
import 'package:myapp/pages/customers_details.dart';
import 'package:myapp/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

var data = <CustomerData>[
  CustomerData(101, 'Akash Parit', 'Kolhapur', 12345, 10000),
  CustomerData(102, 'Yogiraj Shikhare', 'Ichalkaranji', 678910, 20000),
  CustomerData(103, 'Yudarshan Shinde', 'Ichalkaranji', 55555, 10000),
  CustomerData(104, 'Sahil Mulla', 'Miraj', 66666, 16000),
  CustomerData(105, 'Shailesh Lakhapati', 'Karad', 88888, 25000),
  CustomerData(106, 'Mark Rutherford', 'Pune', 77777, 6000),
  CustomerData(107, 'Tony Stark', 'Pune', 99999, 30000),
  CustomerData(108, 'Chris Hemsworth', 'Kolhapur', 10100, 13279),
  CustomerData(109, 'Chris Evans', 'Mumbai', 45455, 7895),
  CustomerData(110, 'Steve Roger', 'Kolhapur', 12345, 10000),
  CustomerData(111, 'Mary Astor', 'US', 98982, 100000),
  CustomerData(112, 'Will Rogers', 'UK', 76584, 5000),
  CustomerData(113, 'John Ford', 'England', 41411, 7861),
  CustomerData(114, 'Kevin Spacey', 'US', 123789, 8000),
  CustomerData(115, 'Robert De Niro', 'Kolhapur', 567894, 254700),
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff3C8CE7), Color(0xff00EAFF)],
                ),
              ),
              child: Center(
                child: Text(
                  "Bank App",
                  style: GoogleFonts.openSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.9),
                ),
              ),
            ),
            SizedBox(height: 80),
            SizedBox(
              height: 40,
              child: RaisedButton(
                child: Text(
                  "View All Customers",
                  style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2),
                ),
                textColor: Colors.black,
                color: Colors.blueAccent,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CustomersDetails(),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
