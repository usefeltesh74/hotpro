import 'package:flutter/material.dart';
import 'package:hotpro/screens/authenticate/sign_in.dart';
import 'package:hotpro/services/auth.dart';
import 'package:hotpro/shared/constants.dart';
import 'package:hotpro/shared/loading%20screen.dart';

class register extends StatefulWidget {
  //const register({super.key});
  final Function toggleview;
  register({ required this.toggleview });
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  String email='';
  String password = '';
  String username='';
  String error = '';
  int teamid = 0;
  bool isloading = false;
  fireauth _auth = fireauth();
  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return isloading ? Loading_screen() : Scaffold(
      backgroundColor: Colors.indigo[600],
      appBar: AppBar(
        leading:  Image.asset("assets/12-121809_premier-league-white-logo-hd-png-download.png",height: 70,width: 70,),
        title: Text(
          "Register page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo[800],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.fromLTRB(40, 50, 40, 0),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: Box_dec,
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text("Register",style: TextStyle(fontSize: 32,color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: text_input_dec.copyWith(hintText: 'Username'),
                    validator: (val) => val!.isEmpty ? "enter your name" : null,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    onChanged: (val){
                      setState(() => username = val);
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: text_input_dec.copyWith(hintText: 'Fantasy Team ID'),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter fantasy ID";
                      } else if (int.tryParse(val) == null) {
                        return "Fantasy ID must be an integer";
                      }
                      return null;
                    },

                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    onChanged: (val){

                      setState(() => teamid = int.tryParse(val) ?? 0);
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: text_input_dec.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? "enter the email" : null,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: text_input_dec.copyWith(hintText: 'Password'),
                    validator: (val) => val!.length < 6 ? "enter password with 7 charachter at least" : null,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    obscureText: true,
                    obscuringCharacter: '*',
                    onChanged: (val){
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
                    child: Text("Sign up"),
                    onPressed: () async {
                      if(_formkey.currentState!.validate()) {
                        setState(()=> isloading = true);
                        dynamic result = await _auth.Signup_with_email_and_password(email, password,username,teamid);
                        if(result == null)
                          {
                            setState(() {
                              error = "enter a valid email";
                              isloading=false;
                            });
                          }
        
                      }
                    },
        
                  ),
                  SizedBox(height: 20,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red , fontSize: 26 ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                    child: Text("Sign in"),
                    onPressed: (){
                      widget.toggleview();
                    },
        
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            )
        ),
      ),
    );
  }
}
