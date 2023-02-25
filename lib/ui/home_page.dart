import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker2/utills/time_list.dart';

import '../main.dart';

final counterProvider = StateProvider<String>((ref) => "お受け取り希望日時選択");

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor:  HexColor('faf0e6'),
      appBar: AppBar(
        backgroundColor:  HexColor('faf0e6'),
        title: const Text('処方箋送信',style: TextStyle(color: Colors.black,)),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                const ListTile(
                  title: Text("・お受け取り希望日時を選択"),
                  subtitle:
                  Text("【注意事項】\nお受け取り希望日時を選択"),
                  isThreeLine: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) {
                            return const CustomDialog();
                          },
                        );
                      },
                      child: Text(ref.watch(counterProvider))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends ConsumerWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogWidth = MediaQuery.of(context).size.width * 3 / 4;

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
              builder: ((context) => Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text('お受け取り希望日選択'),
                    ),
                    body: ListView(
                      children: [
                        ListTile(
                          title: Text('できしだい'),
                          onTap: () => reloadPickUpTime(ref, "できしだい", context),
                        ),
                        ListTile(
                          title: Text('当日'),
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
                          title: Text('翌日以降'),
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

  void reloadPickUpTime(
      WidgetRef ref, String pickUpTime, BuildContext context) {
    ref.read(counterProvider.notifier).update((state) => pickUpTime);
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
                          border: Border(bottom: BorderSide())),
                      height: 30,
                      child: ListTile(
                        dense: true,
                        title: Center(child: Text(businessHourList[index])),
                        onTap: () {
                          ref.read(counterProvider.notifier).update(
                              (state) => "当日 ${businessHourList[index]}");
                        },
                      ));
                })),
      ),
    );
  }
}
