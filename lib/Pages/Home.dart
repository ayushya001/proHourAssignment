
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohour_assignment/Pages/Display.dart';
import 'package:prohour_assignment/Provider/NumberCheckingProvider.dart';
import 'package:prohour_assignment/Utils/RoundButton.dart';
import 'package:prohour_assignment/Utils/utilsColors.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController numberController = TextEditingController();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    // initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    initConnectivity();

  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    
    print("whole re-buikt");
    final mq = MediaQuery.of(context).size;
    final phoneNumberProvider = Provider.of<NumberProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "ProHours",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 54,
                  fontFamily: 'cursive',
                  color: Componentscolor.primary,
                ),
              ),
            ),
            SizedBox(height: mq.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  phoneNumberProvider.updatePhoneNumber(value);
                },
                decoration: InputDecoration(
                  hintText: "Enter your Phone number",
                  labelText: "Phone number",
                  labelStyle: TextStyle(color: Componentscolor.primary),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Componentscolor.borderColorTextformfield,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Componentscolor.primary,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            if (phoneNumberProvider.phoneNumberModel.showError)
              Text(
                "Please enter a 10-digit phone number.",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            SizedBox(height: mq.height*0.03,),
            Container(
              width: mq.width*0.8,
              decoration: BoxDecoration(

              ),
              child: ElevatedButton(
                onPressed: () {
                  if (phoneNumberProvider.phoneNumberModel.number.length != 10) {
                    phoneNumberProvider.showError();
                  }else if(phoneNumberProvider.isInternetConnected!){
                    return;
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DisplayNum()),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    phoneNumberProvider.isInternetConnected &&
                        phoneNumberProvider.phoneNumberModel.number.length == 10
                        ? Componentscolor.primary
                        : Componentscolor.inactive, // Disable button if no internet
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.8,MediaQuery.of(context).size.height*0.06)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Set the circular border radius here
                    ),
                  ),
                ),
                child: Text("Submit"),

              ),
            ),
            SizedBox(height: mq.height*0.02,),
            Consumer<NumberProvider>(
              builder: (context, phoneNumberProvider, child) {
                if (!phoneNumberProvider.isInternetConnected) {
                  return Text(
                    "NO Internet Connection.",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                } else {
                  return Text('Connection Status: ${_connectionStatus.toString()}');
                }
              },
            )
          ],
        ),
      ),
    );
  }


  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("The exception is: " + e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    await _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    final phoneNumberProvider = Provider.of<NumberProvider>(context,listen: false);


    if (result == ConnectivityResult.none) {
      phoneNumberProvider.updateInternetStatus(false);
    } else {
      print("yes it have internet connection");
      phoneNumberProvider.updateInternetStatus(true);
    }
    // setState(() {
    //   _connectionStatus = result;
    // });

  }
}




