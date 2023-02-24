import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

final counterProvider = StateProvider<String>((ref) => "お受け取り希望日時選択");


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

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
                  child: Text(ref.watch(counterProvider)))
            ],),
          ),
        ],
      ),
    );
  }
}

class ClearButtonDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SimpleDialog(
      title: Text("お受け取り希望日時を選択"),
      children: [
        SimpleDialogOption(
          onPressed: () => reloadPickUpTime(ref,"できしだい",context),
          child: Text("できしだい"),
        ),
        SimpleDialogOption(
          onPressed: () => reloadPickUpTime(ref,"当日",context),
          child: Text("当日"),
        ),
        SimpleDialogOption(
          onPressed: () => reloadPickUpTime(ref,"明日以降",context),
          child: Text("明日以降"),
        ),
      ],
    );
  }

  void reloadPickUpTime(WidgetRef ref,String pickUpTime,BuildContext context) {
    ref.read(counterProvider.notifier).update((state) => pickUpTime);
    Navigator.pop(context);
  }
}
