import 'package:blogapp/HomePage.dart';
import 'package:blogapp/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String  name,email,password;
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final databaseReference=Firestore.instance;
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr= new ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(title: Text('SignUp Page'),),
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
                controller: nameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the  Name'
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
                      Signup();

                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Sign Up'),
                )


            ),
          ),
          SizedBox(height: 30,),
          Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                });
              },
              child: Text('Already Account',style: TextStyle(color: Colors.blue),),
            ),
          )

        ],
      ),


    );
  }

  void Signup() async{
    email=emailController.text;
    password=passwordController.text;

    pr.style(
      message: 'Please wait....'
    );
    pr.show();

    final FirebaseUser user= (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;

    String mUid=(await FirebaseAuth.instance.currentUser()).uid;

    await databaseReference.collection('user').document(mUid).setData({
      'user_uid': mUid,
      'user_name': nameController.text,
      'user_email': emailController.text,
      'user_password': passwordController.text

    });
  pr.hide();
  Fluttertoast.showToast(msg: 'Account registered',timeInSecForIos: 1,toastLength: Toast.LENGTH_SHORT);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage() ));



  }
}
