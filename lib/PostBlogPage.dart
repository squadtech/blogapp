
import 'dart:io';

import 'package:blogapp/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

final auth = FirebaseAuth.instance;
final reference = Firestore.instance.collection('Blogs');
final databaseReference = Firestore.instance;

String url;
ProgressDialog pr;

String myName = '';
String abtMe = '';
String myDp = '';
String mDp = '';
String mName = '';
String mUid = '';
String mStatus = '';

DocumentSnapshot mRef;

class PostBlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '\home': (BuildContext context) => HomePage()
      },
      home: Scaffold(
        appBar: AppBar(title: Text('Post Blog'),),
        body: _PostPage(),
      ),
    );
  }
}

class _PostPage extends StatefulWidget {
  @override
  __PostPageState createState() => __PostPageState();
}

class __PostPageState extends State<_PostPage> {
  File _image;
  final TextEditingController _title=new TextEditingController();
  final TextEditingController _desc=new TextEditingController();
  bool _isImage =false;
  bool _isTitle=false;
  bool _isDesc=false;
  bool _isLoading = false;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source:ImageSource.gallery );
    setState(() {
      _image=image as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr =ProgressDialog(context);
    return Container(
      child: SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Padding(padding: const EdgeInsets.only(top: 24.0)),
              new InkWell(
                child: _image == null
                    ? new Image.asset(
                  'assets/images.png',
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.fill,
                )
                    : new Image.file(
                  _image,
                  height: 200,
                  width: 300.0,
                ),
                onTap: () {
                  getImage();
                  _isImage = true;
                },
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  controller: _title,
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  onChanged: (String text) {
                    setState(() {
                      _isTitle = text.length >0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(
                    hintText: "Title",
                    border: new UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  controller: _desc,
                  style: new TextStyle(color: Colors.black, fontSize: 18.0),
                  onChanged: (String text) {
                    setState(() {
                      _isDesc = text.length >0;
                    });
                  },
                  decoration: new InputDecoration.collapsed(
                    hintText: "Description",
                    border: new UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                          width: 5.0),
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(
                  padding: const EdgeInsets.only(
                      left: 45.0, right: 45.0, top: 15.0, bottom: 15.0),
                  color: Colors.blueAccent,
                  elevation: 2.0,
                  child: new Text(
                    "Post",
                    style: new TextStyle(color: Colors.white),
                  ),
                  onPressed: (){

                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Uri> _HandleSubmitted(String title,String desc,File image) async{
    setState(() {
      _isLoading=true;
    });
        mUid= (await FirebaseAuth.instance.currentUser()).uid;
        mRef= await Firestore.instance.collection('User').document((await FirebaseAuth.instance.currentUser()).uid).get();
       pr.style(
         message: 'Uploading Blog'
       );
       pr.show();
       StorageReference ref=FirebaseStorage.instance.ref().child("Blog-Image"+ DateTime.now().millisecondsSinceEpoch.toString());
       StorageUploadTask uploadTask = ref.putFile(image);
       pr.hide();
  }

  }

