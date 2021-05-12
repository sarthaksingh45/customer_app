import 'package:customer_app/Widgets/customer_card.dart';
import 'package:customer_app/screens/add_customer.dart';
import 'package:customer_app/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  void remove(String docId) {
    Firestore.instance.collection('customers').document('$docId').delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //stops: [0.1, 0.5, 0.9],
              colors: [
            Colors.black,
            //Colors.teal[900],
            Colors.green[900],
          ])),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hamare Customer Log',
            style: GoogleFonts.lato(color: Colors.black),
          ),
          // backgroundColor: Colors.amber[700],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return StreamBuilder(
              stream: Firestore.instance
                  .collection('customers')
                  .orderBy('time')
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
                      remove),
                  itemCount: snapshot.data.documents.length,
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AddCustomer(),
            ));
          },
        ),
      ),
    );
  }
}
