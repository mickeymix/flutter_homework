import 'package:flutter/material.dart';
import 'package:flutter_homework/detail/add.dart';
import 'package:flutter_homework/listcard.dart';
import 'package:flutter_homework/listmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Listmodel> lists = List<Listmodel>();

  @override
  void initState() {
    super.initState();
  }

  void _composeEmail() async {
    setState(() async {
      // lists.add(Listmodel(title: "aaaa"));
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Add(),
        ),
      );
      lists.add(Listmodel(title: result));
    });
  }

  _buildRow(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Todos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {

                  return new Listcard(document);
                }).toList(),
              );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    var child = Container(
      child:_buildRow(context)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: _composeEmail,
        tooltip: 'Compose Email',
        child: Icon(Icons.add),
      ),
    );
  }
}
