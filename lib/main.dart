import 'package:firebase_exercise/firebase_options.dart';
import 'package:firebase_exercise/PostPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'nickname.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
        padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailEditingController,
                decoration: const InputDecoration(
                    labelText: 'メールアドレス',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: passwordEditingController,
                decoration: const InputDecoration(
                    labelText: 'パスワード',
                    border: OutlineInputBorder()),
              ),
              OutlinedButton(
                    child: const Text('ログイン'),
                    onPressed: () async{
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailEditingController.text,
                            password: passwordEditingController.text
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context){
                            return Nickname();
                          })
                        );
                      }on FirebaseException catch (e){
                        setState((){
                          infoText = "ログイン失敗";
                        });
                      }
                    },
                   ),
                ElevatedButton(
                  onPressed: ()async {
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailEditingController.text,
                          password: passwordEditingController.text
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return Nickname();
                        }),
                      );
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        infoText = "登録失敗";
                      });
                    }
                  },
                    child: const Text('ユーザー登録', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                  ),
                ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(infoText),
              )
              ])
          ),
        ),
      );
  }
}

