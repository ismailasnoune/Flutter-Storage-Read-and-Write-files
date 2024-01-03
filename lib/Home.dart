import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int Counter = 0;
//find the local path
  Future<String> getApplicationDirectoryPath() async {
    final derectory = await getApplicationDocumentsDirectory();
    return derectory.path;
  }

//reference to the file
  String Path = "";

  Future<File> getFilePath() async {
    final path = await getApplicationDirectoryPath();
    return File("${path}/counter.txt");
  }

  Future<File> writeCounter(int c) async {
    File file = await getFilePath();
    return file.writeAsString('$c');
  }

  Future<int> readCounter() async {
    try {
      final File file = await getFilePath();
      String Contents = await file.readAsString();
      return int.parse(Contents);
    } catch (e) {
      return 0;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCounter().then((data) {
      setState(() {
        Counter = data;
      });
      print(Counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Write File"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Counter : ${Counter}",
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  String Path2 = await getApplicationDirectoryPath();
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            content: Text(Path2),
                          ));

                  print(Path);
                },
                icon: Icon(Icons.file_copy),
                label: Text("GetApplicationDirectoryPath")),
            Text(Path),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Counter++;
          });
          writeCounter(Counter);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
