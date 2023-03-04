import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker2/utills/time_list.dart';

import '../main.dart';

enum RadioValue { FIRST, SECOND }
enum SampleItem { itemOne, itemTwo, itemThree }

final preferredDateProvider = StateProvider<String>((ref) => "お受け取り希望日時選択");
final appBarColorProvider = StateProvider<Enum>((ref) => RadioValue.FIRST);

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RadioValue _gValue = RadioValue.FIRST;

    return Scaffold(
      backgroundColor: HexColor('faf0e6'),
      appBar: AppBar(
        backgroundColor: HexColor('faf0e6'),
        title: const Text('処方箋送信',
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text("・お受け取り希望日時を選択"),
                    subtitle: Text("【注意事項】\nお受け取り希望日時を選択"),
                    isThreeLine: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1, color: Colors.blue),
                        ),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (_) {
                              return const CustomDialog();
                            },
                          );
                        },
                        child: Text(ref.watch(preferredDateProvider),
                            style: const TextStyle(fontSize: 20))),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text("・ご希望医薬品の選択"),
                    subtitle: Text("※流通等の状況によってご希望に添えない場合があります"),
                  ),
                  RadioListTile(
                    title: Text('ジェネリック医薬品'),
                    value: RadioValue.FIRST,
                    groupValue: ref.watch(appBarColorProvider),
                    onChanged: (Enum? value) {
                      ref
                          .watch(appBarColorProvider.notifier)
                          .state = value!;
                    },
                  ),
                  RadioListTile(
                    title: Text('先発医薬品'),
                    value: RadioValue.SECOND,
                    groupValue: ref.watch(appBarColorProvider),
                    onChanged: (Enum? value) {
                      ref
                          .watch(appBarColorProvider.notifier)
                          .state = value!;
                    },
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text("・ご希望医薬品の選択"),
                    subtitle: Text("※流通等の状況によってご希望に添えない場合があります"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => _openPopUpMenu(),
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(color: Colors.white70),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.grey),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: const [
                  ListTile(
                    title: Text("・薬局へのメッセージ（任意）"),
                    subtitle: Text("※薬局への連絡事項がある場合、ご記入ください"),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'メッセージ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: const [
                  ListTile(
                    title: Text("・ご連絡先電話番号（任意）"),
                    subtitle: Text("※薬局から連絡をすることがあります。日中にご連絡可能な電話番号を入力してください。"),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: '電話番号',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openPopUpMenu() {
    return PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
      const PopupMenuItem<SampleItem>(
        value: SampleItem.itemOne,
        child: Text('Item 1'),
      ),
      const PopupMenuItem<SampleItem>(
        value: SampleItem.itemTwo,
        child: Text('Item 2'),
      ),
    ],
    );
  }
}

class CustomDialog extends ConsumerWidget {
  const CustomDialog

  ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogWidth = MediaQuery
        .of(context)
        .size
        .width * 3 / 4;

    return AlertDialog(
      alignment: Alignment.center,
      actions: [
        ElevatedButton(
          child: const Text('閉じる'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      content: SizedBox(
        width: dialogWidth,
        height: dialogWidth * 3 / 5,
        child: Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute(
              builder: ((context) =>
                  Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text(
                        'お受け取り希望日選択',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    body: ListView(
                      children: [
                        ListTile(
                          title: Center(child: Text('できしだい')),
                          onTap: () => reloadPickUpTime(ref, "できしだい", context),
                        ),
                        ListTile(
                          title: Center(child: Text('当日')),
                          trailing: Text('>'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const NextDialog();
                                },
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Center(child: Text('翌日以降')),
                          onTap: () => reloadPickUpTime(ref, "翌日以降", context),
                        ),
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  void reloadPickUpTime(WidgetRef ref, String pickUpTime,
      BuildContext context) {
    ref.read(preferredDateProvider.notifier).update((state) => pickUpTime);
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class NextDialog extends ConsumerWidget {
  const NextDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 400,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('お受け取り時間選択'),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: businessHourList.length,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          )),
                      height: 30,
                      child: ListTile(
                        dense: true,
                        title: Center(child: Text(businessHourList[index])),
                        onTap: () {
                          ref.read(preferredDateProvider.notifier).update(
                                  (state) => "当日 ${businessHourList[index]}");
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ));
                })),
      ),
    );
  }
}
