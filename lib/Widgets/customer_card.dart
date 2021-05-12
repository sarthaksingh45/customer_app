import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final String phoneNo;
  final String address;
  final String lastTime;
  final String docId;
  final Function remove;
  CustomerCard(this.name, this.phoneNo, this.address, this.lastTime, this.docId,
      this.remove);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        color: Colors.amber,
        elevation: 15,
        shadowColor: Colors.grey[900],
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            // decoration:
            //     BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 34,
                      ),
                    ),
                    DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text('Edit'),
                          value: 'edit',
                        ),
                        DropdownMenuItem(
                          child: Text('Delete'),
                          value: 'delete',
                        )
                      ],
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        if (value == 'delete') {
                          remove(docId);
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 550,
                  child: Text(
                    phoneNo,
                    style: GoogleFonts.lato(
                        color: Colors.green[900], fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 550,
                  child: Text(
                    address,
                    style: GoogleFonts.lato(
                        color: Colors.green[900], fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 550,
                  child: Text(
                    lastTime,
                    style: GoogleFonts.lato(color: Colors.black, fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
