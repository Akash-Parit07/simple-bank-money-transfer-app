import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/model/cust_data.dart';
import 'package:myapp/pages/transaction_details.dart';
import 'package:myapp/utils/database_helper.dart';

class TransferMoney extends StatefulWidget {
  const TransferMoney({Key key, this.accno, this.name}) : super(key: key);

  final int accno;
  final String name;

  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  CustomerData data;
  DatabaseHelper helper;
  bool loading;

  TextEditingController _accnoTEC;
  TextEditingController _amountTEC;
  TextEditingController _nameTEC;

  @override
  void initState() {
    super.initState();
    loading = true;
    _nameTEC = TextEditingController();
    _accnoTEC = TextEditingController();
    _amountTEC = TextEditingController();
    helper = DatabaseHelper();
    getData();
  }

  getData() async {
    try {
      data = await helper.getClient(widget.accno);
      setState(() {
        loading = false;
      });
    } catch (e) {
      message("Error while fetching data....");
    }
  }

  Widget _buildNameField() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 5.0, right: 10),
      child: TextField(
        controller: _nameTEC,
        style: GoogleFonts.openSans(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
        onChanged: (value) {
          //debugPrint('Something changed in Title Text Field');
        },
        decoration: InputDecoration(
          labelText: 'To Name',
          labelStyle: GoogleFonts.openSans(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget _buildAccNoField() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 5.0, right: 10),
      child: TextField(
        controller: _accnoTEC,
        style: GoogleFonts.openSans(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
        onChanged: (value) {
          //debugPrint('Something changed in Title Text Field');
        },
        decoration: InputDecoration(
          labelText: 'To Account Number',
          labelStyle: GoogleFonts.openSans(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 5.0, right: 10),
      child: TextField(
        controller: _amountTEC,
        style: GoogleFonts.openSans(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
        onChanged: (value) {
          //debugPrint('Something changed in Title Text Field');
        },
        decoration: InputDecoration(
          labelText: 'Amount',
          labelStyle: GoogleFonts.openSans(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget _buildTransferBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => transfer(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        color: Colors.blue[400],
        child: Text(
          'Transfer',
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

  transfer() async {
    CustomerData toData;
    int tempToAccno;
    int amtToTransfer;
    int res1 = 0;
    int res2 = 0;
    var parsed = DateTime.parse(DateTime.now().toString());
    var dateTime = parsed.day.toString() +
        "/" +
        parsed.month.toString() +
        "/" +
        parsed.year.toString() +
        " " +
        parsed.hour.toString() +
        ":" +
        parsed.minute.toString();

    if (_accnoTEC != null || _amountTEC != null || _nameTEC != null) {
      try {
        tempToAccno = int.parse(_accnoTEC.text);
        amtToTransfer = int.parse(_amountTEC.text);
        loading = true;
        toData = await helper.getClient(tempToAccno);
      } on Exception catch (e) {
        message("Please enter valid fields");
      }
    } else {
      message("Please enter above fields..");
      return;
    }

    if ((toData.accountNo == tempToAccno) &&
        (toData.custName == _nameTEC.text)) {
      if (data.bal > amtToTransfer) {
        data.bal = data.bal - amtToTransfer; // Debit amount
        toData.bal = toData.bal + amtToTransfer; // Credit amount

        //Update database
        try {
          res1 = await helper.updateCustomer(data);
          res2 = await helper.updateCustomer(toData);
          message("Redirecting...Don't press back button...");
          if (res1 == 1 && res2 == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TransactionDetails(
                    isDone: true,
                    amount: double.parse(_amountTEC.text),
                    fromName: data.custName,
                    toName: toData.custName,
                    dateTime: dateTime,
                    toAcNo: toData.accountNo,
                  ),
                ));
          }
        } catch (e) {
          message("Redirecting...Don't press back button...");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => TransactionDetails(
                        isDone: false,
                        amount: double.parse(_amountTEC.text),
                        fromName: data.custName,
                        toName: toData.custName,
                        dateTime: dateTime,
                        toAcNo: toData.accountNo,
                      )));
        }
      } else {
        message("Redirecting...Don't press back button...");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TransactionDetails(
                isDone: false,
                amount: double.parse(_amountTEC.text),
                fromName: data.custName,
                toName: toData.custName,
                dateTime: dateTime,
                toAcNo: toData.accountNo,
              ),
            ));
      }
    } else {
      message("Redirecting...Don't press back button...");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TransactionDetails(
              isDone: false,
              amount: double.parse(_amountTEC.text),
              fromName: data.custName,
              toName: toData.custName,
              dateTime: dateTime,
              toAcNo: toData.accountNo,
            ),
          ));
    }
  }

  message(String msg) {
    Fluttertoast.showToast(
      msg: msg, toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Money  Transfer',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 30.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  child:
                                      Icon(Icons.person, color: Colors.purple),
                                ),
                              ),
                            ),

                            // Textbox
                            SizedBox(height: 10.0),
                            _buildNameField(),

                            //Textbox
                            SizedBox(height: 10.0),
                            _buildAccNoField(),

                            //Textbox
                            SizedBox(height: 10.0),
                            _buildAmountField(),

                            SizedBox(height: 50.0),
                            //transfer Button
                            _buildTransferBtn(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
