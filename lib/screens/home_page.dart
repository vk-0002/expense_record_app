import 'package:flutter/material.dart';
import 'package:money_spend_app/screens/login.dart';
import 'package:money_spend_app/screens/payment_history/history_tabbar.dart';
import 'package:money_spend_app/screens/widgets/loading_screen.dart';

import 'package:money_spend_app/services/firebase.dart';
import 'package:money_spend_app/screens/widgets/buttons.dart';
import 'package:money_spend_app/services/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../services/upi_pay.dart';


class HomeScreen extends StatefulWidget {

  final String? result;

  const HomeScreen(this.result);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  TextEditingController? cost= TextEditingController();
  TextEditingController? description= TextEditingController();
  TextEditingController? upi= TextEditingController();

  String? receiverName;


  @override
  void initState() {

    checkIsLogedIn();
    getUpiDetailFromQR();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ],
          )
      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height/1,
            width: MediaQuery.of(context).size.width/1,

            child: Card(

              shadowColor: Colors.black12,
              elevation: 10,
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide.none
              ),

              color: Colors.white,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 60,),

                    Row(children: [

                      IconButton(
                          onPressed: (){

                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HistoryTabBar(),
                                ));

                          },
                          icon: Icon(Icons.history)
                      )

                    ],),

                    const Center(
                      child: Text(
                        "Garaj ahe ka ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "vaypat khrch nko kru.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),


                    const SizedBox(height: 30,),

                    Row(
                      children: [

                        Spacer(),

                        IconButton(
                            onPressed: (){

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QRScanner()),
                              );

                            },
                            icon: Icon(
                              Icons.qr_code_scanner
                            )),
                      ],
                    ),

                    const Text(
                      "UPI ID",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        controller: upi,
                        onChanged: (value){
                          setState(() {});
                        },

                        decoration:  InputDecoration(
                          hintText: "UPI ID",
                          //errorText: RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(description!.text.toString()) || description!.text.toString()=="" ? null : "password must contain 1 lower,upper,special\nand numeric",

                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        )
                    ),

                    const SizedBox(height: 20,),


                    const Text(
                      "Cost",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        keyboardType: TextInputType.number,

                        controller: cost,
                        onChanged: (value){

                          setState(() {});

                        },
                        decoration:  InputDecoration(

                          hintText: "Cost",
                          //errorText: RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$').hasMatch(cost!.text.toString()) || cost!.text.toString()==""? null : "Enter valid Email" ,
                          hintStyle: const TextStyle(

                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        )
                    ),


                    const SizedBox(height: 20,),

                    const Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        controller: description,
                        onChanged: (value){
                          setState(() {});
                        },

                        decoration:  InputDecoration(
                          hintText: "Description",
                          //errorText: RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(description!.text.toString()) || description!.text.toString()=="" ? null : "password must contain 1 lower,upper,special\nand numeric",

                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                        )
                    ),

                    const SizedBox(height: 40,),

                    Center(
                      child: SizedBox(

                          width: MediaQuery.of(context).size.width,

                          child: CustomButton(
                            text: "Pay",
                            onPress: (){

                              if(cost!.text!=null  && cost!.text.isNotEmpty && description!.text!=null && description!.text.isNotEmpty && upi!.text!=null && upi!.text.isNotEmpty)
                              {

                                Database().createRecord(cost?.text, description!.text,DateTime.now());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UPI(amount: cost!.text,upiId: upi!.text,receiverName: receiverName,description: description!.text,),
                                ));
                              }else{

                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('empty field bhr na bhadya'),
                                    content: const Text('error 106'),
                                    actions: <Widget>[

                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );

                              }
                            },
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                    Center(
                      child: SizedBox(

                          width: MediaQuery.of(context).size.width,

                          child: CustomButton(
                            text: "Add",
                            onPress: ()  {

                              if(cost!.text!=null  && cost!.text.isNotEmpty && description!.text!=null && description!.text.isNotEmpty )
                              {

                                 Database().createRecord(cost?.text, description!.text,DateTime.now());

                                 showDialog<String>(
                                   context: context,
                                   builder: (BuildContext context) => AlertDialog(
                                     title: const Text('Record added'),
                                     content: const Text('done'),
                                     actions: <Widget>[

                                       TextButton(
                                         onPressed: () {
                                           Navigator.pop(context, 'OK');
                                           cost!.text="";
                                           description!.text='';
                                           upi!.text='';
                                         },
                                         child: const Text('OK'),
                                       ),
                                     ],
                                   ),
                                 );


                              }else{


                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('empty field bhr na bhadya'),
                                    content: const Text('error 106'),
                                    actions: <Widget>[

                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );

                              }

                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void getUpiDetailFromQR() {

     if(widget.result!.isNotEmpty){

      // print(widget.result);
      // String  a="upi://pay?pa=omkarpatil5566-1@okaxis&pn=Omkar%20Patil&am=100.00&cu=INR&aid=uGICAgIC184HtMA";
      // String b="upi://pay?pa=8698171281@ybl&pn=Omkar%20Patil&mc=0000&mode=02&purpose=00";

      List<String> l=widget.result!.split("&");


      for (String element in l) {

        if(element.contains("pa=")){

          upi!.text= element.split("=").last;

        }
        if(element.contains("am=")){
          cost!.text=element.split("=").last;
        }
        if(element.contains("pn=")){
          receiverName=element.split("=").last;
        }


      }
      setState(() {

      });

     }

  }

  void checkIsLogedIn() async{

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    if(prefs!=null){
      if(prefs.getBool(isLoggedIn)==null){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => const LoginScreen()),
          ModalRoute.withName('/'),
        );
      }
    }


  }
}
