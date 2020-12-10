import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:BasicBankApp/model/cust_data.dart';
import 'package:BasicBankApp/pages/customer_view.dart';
import 'package:BasicBankApp/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CustomersDetails extends StatefulWidget {
  @override
  CustomersDetailsState createState() {
    return new CustomersDetailsState();
  }
}

class CustomersDetailsState extends State<CustomersDetails> {
  DatabaseHelper helper = DatabaseHelper();
  List<CustomerData> custData;
  var tempData;
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    message("Connecting to Database.");
  }

  _getList() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<CustomerData>> custListFuture =
          helper.getCustomerDataMapList();
      custListFuture.then((custData) {
        setState(() {
          this.custData = custData;
          loading = false;
        });
      });
    });
  }

  Widget bodyData() => ListView.builder(
        itemCount: custData.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            elevation: 1.0,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink[200],
                child: Icon(
                  Icons.account_balance_rounded,
                  color: Colors.black,
                ),
              ),
              title: Text(
                this.custData[position].custName,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "A/c - " + this.custData[position].accountNo.toString(),
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CustomerView(
                    acno: custData[position].accountNo,
                    name: custData[position].custName,
                    addr: custData[position].custAddr,
                    phone: custData[position].phoneNo,
                    bal: custData[position].bal,
                  ),
                ));
              },
            ),
          );
        },
      );

  message(String msg) {
    Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  refreshDetails() {
    setState(() {
      loading = true;
    });
    message("Refreshing..");
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    if (custData == null) {
      custData = List<CustomerData>();
      _getList();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
          "Customer Details",
          style: GoogleFonts.openSans(
              fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Icon(Icons.refresh),
            ),
            onTap: () => refreshDetails(),
          )
        ],
      ),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : bodyData(),
    );
  }
}
