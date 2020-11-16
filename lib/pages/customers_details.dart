import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/model/cust_data.dart';
import 'package:myapp/pages/customer_view.dart';
import 'package:myapp/utils/database_helper.dart';
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

  Widget bodyData() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            onSelectAll: (b) {},
            sortColumnIndex: 1,
            sortAscending: true,
            columnSpacing: 10,
            columns: <DataColumn>[
              DataColumn(
                label: Text("Account No."),
                numeric: true,
                tooltip: "A/c number",
              ),
              DataColumn(
                label: Text("Customer Name"),
                numeric: false,
                tooltip: "Name of customer",
              ),
              DataColumn(
                label: Text("Address"),
                numeric: false,
                tooltip: "Address of customer",
              ),
              DataColumn(
                label: Text("Phone No."),
                numeric: false,
                tooltip: "Phone no of customer",
              ),
              DataColumn(
                label: Text("Balance"),
                numeric: false,
                tooltip: "Balance into account",
              ),
            ],
            rows: custData
                .map(
                  (custData) => DataRow(
                    cells: [
                      DataCell(
                        GestureDetector(
                          child: Center(
                              child: Text(custData.accountNo.toString())),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CustomerView(
                              acno: custData.accountNo,
                              name: custData.custName,
                              addr: custData.custAddr,
                              phone: custData.phoneNo,
                              bal: custData.bal,
                            ),
                          )),
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        GestureDetector(
                          child: Text(custData.custName),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CustomerView(
                              acno: custData.accountNo,
                              name: custData.custName,
                              addr: custData.custAddr,
                              phone: custData.phoneNo,
                              bal: custData.bal,
                            ),
                          )),
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        GestureDetector(
                          child: Text(custData.custAddr),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CustomerView(
                              acno: custData.accountNo,
                              name: custData.custName,
                              addr: custData.custAddr,
                              phone: custData.phoneNo,
                              bal: custData.bal,
                            ),
                          )),
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        GestureDetector(
                          child: Text(custData.phoneNo.toString()),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CustomerView(
                              acno: custData.accountNo,
                              name: custData.custName,
                              addr: custData.custAddr,
                              phone: custData.phoneNo,
                              bal: custData.bal,
                            ),
                          )),
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        GestureDetector(
                          child: Text(custData.bal.toString()),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => CustomerView(
                              acno: custData.accountNo,
                              name: custData.custName,
                              addr: custData.custAddr,
                              phone: custData.phoneNo,
                              bal: custData.bal,
                            ),
                          )),
                        ),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
                )
                .toList()),
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  bodyData(),
                ],
              ),
            ),
    );
  }
}
