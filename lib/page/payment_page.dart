import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tukerin/constant_builder.dart';
import 'package:tukerin/main.dart';
import 'package:tukerin/models/station.dart';
import 'package:tukerin/page/success_confirmationpage.dart';
import 'package:tukerin/page/widgets/appTheme.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  Station station;

  PaymentPage(this.station, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<PaymentPage> createState() => _PaymentPageState(station);
}

class _PaymentPageState extends State<PaymentPage> {
  final Station station;

  _PaymentPageState(
    this.station
  );

  CollectionReference transactionHistory = firestore.collection('transactionHistory');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Color ccNameShadow = darkGrey;
  Color ccNumberShadow = darkGrey;
  Color expDateShadow = darkGrey;
  Color cvcShadow = darkGrey;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: appColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Form( //GROUP OF TEXT FIELD
                key: _keyForm,
                child: Column( 
                  children: [
                    Text(
                      "Please fill your Credit Card Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: darkFont
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Stack( //TEXT FIELD FOR CC NAME
                      children:[
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(23),
                            boxShadow: [
                              BoxShadow(
                                color: ccNameShadow.withOpacity(0.2),
                                offset: const Offset(0,5),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            autocorrect: false,
                            validator: (value) {
                              if(value!.isEmpty){
                                setState(() {ccNameShadow = Colors.red;});
                                return 'Please enter this field';
                              }
                              setState(() {ccNameShadow = darkGrey;});
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: 'CC Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
      
                    const SizedBox(height: 30,),
      
                    Stack( //TEXT FIELD FOR CC NUMBER
                      children:[
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(23),
                            boxShadow: [
                              BoxShadow(
                                color: ccNumberShadow.withOpacity(0.2),
                                offset: const Offset(0,5),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            autocorrect: false,
                            validator: (value) {
                              if(value!.isEmpty){
                                setState((){ccNumberShadow = Colors.red;});
                                return 'Please enter this field';
                              }
                              String pattern = r'^[0-9]+';
                              RegExp regex = RegExp(pattern);
                              if(!regex.hasMatch(value)){
                                setState((){ccNumberShadow = Colors.red;});
                                return 'Only Number Allowed!';
                              }
                              setState((){ccNumberShadow = darkGrey;});
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: 'Credit Card Number',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ]
                    ),
      
                    const SizedBox(height: 30,),
      
                    Row( //ROW FOR EXP DATE AND CVC
                      children: [
                        Expanded(
                          child: Stack( //TEXT FIELD FOR EXP DATE
                            children:[
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                  boxShadow: [
                                    BoxShadow(
                                      color: expDateShadow.withOpacity(0.2),
                                      offset: const Offset(0,5),
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  autocorrect: false,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      setState(() {expDateShadow = Colors.red;});
                                      return 'Please enter this field';
                                    }
                                    String pattern = r'[0-9][0-9]/[0-9][0-9]';
                                    RegExp regex = RegExp(pattern);
                                    if(!regex.hasMatch(value)){
                                      setState(() {expDateShadow = Colors.red;});
                                      return 'Format Invalid!';
                                    }
                                    setState(() {expDateShadow = darkGrey;});
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    hintText: 'Exp Date',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                        const SizedBox(width: 30,),
                        Expanded(
                          child: Stack( //TEXT FIELD FOR CVC
                            children:[
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cvcShadow.withOpacity(0.2),
                                      offset: const Offset(0,5),
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  autocorrect: false,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      setState((){cvcShadow = Colors.red;});
                                      return 'Please enter this field';
                                    }
                                    String pattern = r'[0-9][0-9][0-9]';
                                    RegExp regex = RegExp(pattern);
                                    if(!regex.hasMatch(value)){
                                      setState((){cvcShadow = Colors.red;});
                                      return 'Not Valid!';
                                    }
                                    setState((){cvcShadow = darkGrey;});
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    hintText: 'CVC',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40,),

              Column(
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 17,
                      color: darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 2
                    ).format(station.price),
                    style: TextStyle(
                      fontSize: 19,
                      color: darkGrey,
                      fontWeight: FontWeight.w600,
                      height: 1.2
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        inputData(uid);
                        
                      },
                      style: buttonStyle,
                      
                      child: const Center(
                        child: Text(
                          'Pay',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void inputData(String uid) {
    if(_keyForm.currentState!.validate()){
      final data = {
        "address" : station.address,
        "latitude" : station.latitude,
        "longitude" : station.longitude,
        "orderDate" : Timestamp.now(),
        "stationName" : station.name,
        "totalPrice" : station.price,
        "uid" : uid,
      };
      
      transactionHistory.add(data);

      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const SuccessfullPage()),
      );
    }
  }
}