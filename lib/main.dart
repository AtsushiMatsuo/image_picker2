import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp((const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('処方箋送信'),
      ),
      body: Column(
        children: [
          Card(
            child: Column(children: [
              Text("お受け取り希望日時を選択"),
              Divider(),
              Text("【注意事項】"),
              Text("・処方箋の有効期限は発行日を含めて４日間です"),
              ElevatedButton(
                  onPressed: (){
                    showDialog<void>(
                      context: context,
                      builder: (_) {
                        return ClearButtonDialog();
                      },
                    );
                  },
                  child: Text("お受け取り希望日時"))
            ],),
            ),
        ],
      ),
    );
  }
}

class ClearButtonDialog extends ConsumerWidget {
  
  const ClearButtonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}




