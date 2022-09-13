import 'package:flutter/material.dart';
import 'package:money_spend_app/screens/home_page.dart';
import 'package:money_spend_app/screens/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController? userName= TextEditingController();
  TextEditingController? userPassword= TextEditingController();


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
            height: MediaQuery.of(context).size.height/1.8,
            width: MediaQuery.of(context).size.width/1.2,

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

                    const SizedBox(height: 30,),

                    const Center(
                      child: Text(
                        "Create Account or Log in",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),

                    const SizedBox(height: 50,),

                    const Text(
                      "Email Address  *",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        controller: userName,
                        onChanged: (value){

                          setState(() {});

                        },
                        decoration:  InputDecoration(
                          hintText: "Enter Email",
                          errorText: RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$').hasMatch(userName!.text.toString()) || userName!.text.toString()==""? null : "Enter valid Email" ,
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
                      "Password  *",
                      style: TextStyle(
                        color: Colors.black,

                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        controller: userPassword,
                        onChanged: (value){
                          setState(() {});
                        },
                        obscureText: true,
                        decoration:  InputDecoration(
                          hintText: "Enter Password",
                          // errorText: RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@ #\$&*~]).{8,}$').hasMatch(userPassword!.text.toString()) || userPassword!.text.toString()=="" ? null : "password must contain 1 lower,upper,special\nand numeric",

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
                            text: "Sign IN",
                            onPress: () async {

                              final prefs = await SharedPreferences.getInstance();
                              if(prefs!=null){
                                
                                prefs.setBool(isLoggedIn, true);
                                prefs.setString(name, userName!.text.replaceAll(".", "_"));
                                prefs.setString(password, userPassword!.text);
                                
                                  
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute<void>(builder: (BuildContext context) => const HomeScreen("")),
                                    ModalRoute.withName('/'),
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
}