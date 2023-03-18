import 'package:flutter/material.dart';
import 'package:read_json_file_flutter_template/read_json.dart';
import 'package:url_launcher/url_launcher.dart';




void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Excel sheet from list of data',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List myList=[];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read json file from project folder"),
      ),
      body: Center(
        child:
        myList.isEmpty?const Text("Please click below button to get the data"):  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:List.generate(myList.length, (index) {
            return Card(
              child: ListTile(
                onTap: (){
                  launchUrl(Uri.parse(myList[index]["link"].toString()));
                },
                title: Text(myList[index]["title"].toString()),
                subtitle:Text(myList[index]["link"].toString()) ,
              ),
            );
          }),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
      ReadJsonFile.readJsonData(path: "assets/sample_json.json").then((value) {
      setState(() {
        myList=value["data"];
      });
    });
        },
        label: const Text("Read data from json file"),
      ),
    );
  }
}
