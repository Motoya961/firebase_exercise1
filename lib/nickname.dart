import 'package:flutter/material.dart';

import 'PostPage.dart';

class Nickname extends StatefulWidget {
  const Nickname({Key? key}) : super(key: key);

  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {

  String nickName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            onChanged: (text){
              nickName = text;
            },
            decoration: const InputDecoration(
                labelText: 'ニックネームを入力してください。',
                border: OutlineInputBorder()),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return Posts(nickName: nickName);
                  }),
                );
              },
              child: const Text('完了')
          ),
        ],
      ),
    );
  }
}
