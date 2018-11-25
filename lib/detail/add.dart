import 'package:flutter/material.dart';
import 'package:flutter_homework/detail/FirestoreUtil.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String _text = '';
  firestoreUtils mFireStoreUtil = firestoreUtils();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _addtext() {
    setState(() {
      // lists.add(Listmodel(title: "aaaa"));
      mFireStoreUtil.addData({'isFinished': false,'name':_text});

      Navigator.pop(context, _text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                  child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(labelText: "please insert task."),
                        onChanged: (String newString) {
                          setState(() {
                            _text = controller.text;
                          });
                        },
                      ))),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: SizedBox(
                    width: 300,
                    child: RaisedButton(
                      child: const Text('ADD TASK'),
                      onPressed: _addtext,
                    )),
              ),
            ]),
      ),
    );
  }
}
