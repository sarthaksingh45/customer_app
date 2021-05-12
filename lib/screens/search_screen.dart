import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/customer_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(children: [
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Seach here....'),
            onChanged: (value) {
              setState(() {});
            },
          ),
          if (_textController.text != null)
            Expanded(
                child: StreamBuilder(
              stream: Firestore.instance
                  .collection('customers')
                  .where('name',
                      isGreaterThanOrEqualTo: '${_textController.text}')
                  .where('name',
                      isLessThan:
                          '${_textController.text}' + 'zzzzzzzzzzzz zzzzzzzzzz')
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemBuilder: (ctx, index) => CustomerCard(
                      snapshot.data.documents[index]['name'],
                      snapshot.data.documents[index]['phone'],
                      snapshot.data.documents[index]['address'],
                      snapshot.data.documents[index]['time'],
                      snapshot.data.documents[index].documentID,
                      null),
                  itemCount: snapshot.data.documents.length,
                );
              },
            ))
        ]));
  }
}
