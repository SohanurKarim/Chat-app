import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn_14/widgets/auth/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;


  Future<void> _submitAuthForm(
    String email,
    String password,
    String username,
    XFile? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);




        //Here code for Image Upload
        File imageFile = File(image!.path);
       final ref = FirebaseStorage.instance
           .ref()
           .child('user_image')
           .child(userCredential.user!.uid + '.jpg');

          //This line is user for send image
           await ref.putFile(imageFile);

           //This line is user for get firebase storage location url
           final url = await ref.getDownloadURL();

        //Here code for User Info
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username':username,
          'email':email,
          'password':password,
          'image_url':url,
        }
        );


      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, Please check your credentials!';
      if (err.message != null) {
        message = err.message!;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
