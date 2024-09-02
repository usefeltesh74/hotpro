import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotpro/screens/authenticate/authenticate.dart';
import 'package:hotpro/screens/authenticate/register.dart';
import 'package:hotpro/services/auth.dart';
import 'package:hotpro/shared/constants.dart';
import 'package:hotpro/shared/loading%20screen.dart';

class sign_in extends StatefulWidget {
  //const sign_in({super.key});
  final Function toggleview;
  const sign_in({super.key, required this.toggleview});
  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  @override
  final fireauth _auth = fireauth();
  String email = '';
  String password = '';
  final _formkey = GlobalKey<FormState>();
  String error = '';
  bool isloading = false;
  Widget build(BuildContext context) {
    return isloading ? Loading_screen() : Scaffold(
      backgroundColor: Colors.indigo[600],
      appBar: AppBar(
        leading:  Padding(padding:EdgeInsets.fromLTRB(10, 0, 0, 0),child: Image.asset("assets/12-121809_premier-league-white-logo-hd-png-download.png",height: 70,width: 70,)),
        title: Text(
            "Sign in page",
            style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo[800],

      ),
      body: SingleChildScrollView(
        child: Container(
          
          margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
          decoration: Box_dec,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
        
            key: _formkey,
            child: Column(
              children: <Widget>[

                Text("Sign in",style: TextStyle(fontSize: 32,color: Colors.black,fontWeight: FontWeight.bold),),
                Image.asset("assets/epl.png",height: 150,width: 150,),
                //SizedBox(height: 20,),
                //SizedBox(height: 20,),
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
                  child: Text("Sign in"),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() => isloading = true);
                        dynamic result = await _auth.Signin_with_email_and_password(email, password);
                        if (result != null) {
                          print('Sign-in successful, user ID: ${result.uid}');  // Debugging statement
                        } else {
                          setState(() {
                            error = "The Email or Password is Wrong";
                            isloading = false;
                          });
                        }
                      }
                    }


                ),
                SizedBox(height: 20,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red , fontSize: 16 ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  child: Text("Sign up"),
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
