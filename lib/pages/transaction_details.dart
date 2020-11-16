import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionDetails extends StatefulWidget {
  final bool isDone;
  final double amount;
  final String toName, dateTime, fromName;
  final int toAcNo;
  const TransactionDetails(
      {Key key,
      this.isDone,
      this.amount,
      this.toName,
      this.dateTime,
      this.toAcNo,
      this.fromName})
      : super(key: key);
  @override
  TransactionDetailsState createState() => TransactionDetailsState();
}

class TransactionDetailsState extends State<TransactionDetails> {
  @override
  void initState() {
    super.initState();
    print(widget.isDone);
  }

  Widget icon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 40,
              child: widget.isDone
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 60,
                    )
                  : Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    )),
        ),
      ],
    );
  }

  Widget amount() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        "Rs. " + widget.amount.toString(),
        style: GoogleFonts.openSans(
            fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  Widget statusText() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: widget.isDone
            ? Text(
                "Payment Successful",
                style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              )
            : Text(
                "Transaction Failed",
                style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ));
  }

  Widget transactionDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Card(
        // elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        color: Colors.white,
        child: ListTile(
          title: Text(
            "Transaction Details",
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget fromName() {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "From   :  " + widget.fromName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget amountTransfered() {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Amount  :  " + widget.amount.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toName() {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "To     :  " + widget.toName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toAcNo() {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "To A/c No.  :  " + widget.toAcNo.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dateTime() {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Date & Time :  " + widget.dateTime,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDoneBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: 160,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.blue[400],
        child: Text(
          'Done',
          style: GoogleFonts.openSans(
            color: Colors.white,
            letterSpacing: 1.2,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.white,
        //elevation: 0.0,
        title: Text(
          "Payment",
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            icon(),
            amount(),
            statusText(),
            transactionDetails(),
            fromName(),
            amountTransfered(),
            toName(),
            toAcNo(),
            dateTime(),
            buildDoneBtn(),
          ],
        ),
      ),
    );
  }
}
