import 'package:blogapp/HomePage.dart';
import 'package:blogapp/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email,password;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login Page'),),
      body: ListView(

          children: <Widget>[
            Center(
              child: Container(
                height: 200,
                width: 300,
                child: Image.asset('assets/logo.png')
              ),
            ),
            Center(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                 border: Border.all()
                ),
                child: TextField(
                  controller: emailController,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Enter the  email'
                   ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the password'
                  ),

                ),
              ),
            ),
            SizedBox(height: 50,),
            Center(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                ),
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Login'),
                )


              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                  });
                },
                child: Text('Create Account',style: TextStyle(color: Colors.blue),),
              ),
            )

          ],
        ),


    );
  }

  void Login(){
    email=emailController.text;
    password=passwordController.text;
    pr.style(message: 'wait......');
    pr.show();


    firebaseAuth.signInWithEmailAndPassword(email:email, password: password);

    pr.hide();
    Fluttertoast.showToast(msg: 'Successfully Login');

  }
}
