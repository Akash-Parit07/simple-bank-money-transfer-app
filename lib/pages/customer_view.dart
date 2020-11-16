import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/pages/transfer_money.dart';

class CustomerView extends StatefulWidget {
  final int acno, phone;
  final String name, addr;
  final double bal;

  const CustomerView(
      {Key key, this.acno, this.phone, this.name, this.addr, this.bal});
  @override
  CustomerViewState createState() => CustomerViewState();
}

class CustomerViewState extends State<CustomerView> {
  @override
  void initState() {
    super.initState();
    //print(widget.acno.toString() + widget.name + widget.bal.toString());
  }

  Widget bodyData() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 16.0, top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.blue[300],
                  child: ListTile(
                    title: Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.purple),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Account No. :  " + widget.acno.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Address       :  " + widget.addr,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Phone No.   :  " + widget.phone.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Balance       :  " + widget.bal.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customer",
          style: GoogleFonts.openSans(
              fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
        centerTitle: true,
      ),
      body: bodyData(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => TransferMoney(
                    accno: widget.acno,
                    name: widget.name,
                  )));
        },
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.arrow_forward_ios),
        label: Text(
          "Transfer Money",
          style: GoogleFonts.openSans(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
