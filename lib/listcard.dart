import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/detail/FirestoreUtil.dart';
import 'package:flutter_homework/listmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Listcard extends StatefulWidget {
  Listcard(this.list);

  final DocumentSnapshot list;

  @override
  _MyListcardState createState() => _MyListcardState();
}

class _MyListcardState extends State<Listcard> {
  bool checkboxValueA = false;
  TextDecoration textDecoration = TextDecoration.none;
  firestoreUtils mFireStoreUtil = firestoreUtils();
  @override
  void initState() {
    super.initState();
    checkboxValueA = widget.list.data["isFinished"];

  }

  bool composeCheckbox(bool value) {
    setState(() {
      checkboxValueA = value;
      checkboxValueA ? textDecoration = TextDecoration.lineThrough : textDecoration = TextDecoration.none;
      _updateIsFinishToFireStore(widget.list.documentID,{'isFinished':checkboxValueA,'name':widget.list.data["name"]});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: SizedBox(
                      width: 300,
                      child: RichText(
                        text: new TextSpan(
                          text: 'This item costs ',
                          children: <TextSpan>[
                            new TextSpan(
                              text: widget.list.data["name"],
                              style: new TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                decoration: checkboxValueA
                                    ? textDecoration = TextDecoration.lineThrough
                                    : textDecoration = TextDecoration.none,
                              ),
                            ),
//                            TextSpan(
//                              text: widget.list.data["name"],
//                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Checkbox(value: checkboxValueA, onChanged: composeCheckbox),
                ]),
          ),
        ],
      ),
    );
  }

  void _updateIsFinishToFireStore(String documentID,var newValue) {
    mFireStoreUtil.updateData(documentID, newValue);
  }
}
