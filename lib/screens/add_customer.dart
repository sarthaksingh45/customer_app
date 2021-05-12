import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../Widgets/date_picker.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  var _typedName = '';
  var _typedPhone = '';
  var _typedAddress = '';
  var _typedTime = '';
  final _nameController = new TextEditingController();
  final _phoneController = new TextEditingController();
  final _addressController = new TextEditingController();
  final _timeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void setDate(DateTime pickedDate) {
    setState(() {
      _typedTime = pickedDate.toString();
    });
  }

  Future<void> _uploadCustomer() async {
    try {
      FocusScope.of(context).unfocus();

      Firestore.instance.collection('customers').add({
        'name': _typedName,
        'time': _typedTime,
        'phone': _typedPhone,
        'address': _typedAddress,
      });
    } catch (err) {}
    _nameController.clear();
    _phoneController.clear();
    _addressController.clear();
    _timeController.clear();
  }

  Future<void> trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      try {
        await _uploadCustomer();
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Count Add ....Internet issue')));
        return;
      }
      Navigator.of(context).pop();
    }
    return;
  }

  @override
  Widget build(BuildContext context2) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer ki jaankaari Bharo',
          style: GoogleFonts.lato(color: Colors.black),
        ),
        //backgroundColor: Colors.amber[700],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'name',
                    icon: Icon(Icons.contacts),
                  ),
                  validator: (value) {
                    if (value == null) return 'Enter Name';
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _typedName = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    //focusColor: Colors.green,
                    hintText: 'Phone Number',
                    icon: Icon(Icons.phone),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _typedPhone = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Enter Phone Number';

                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 3,
                  controller: _addressController,
                  decoration: InputDecoration(
                    //focusColor: Colors.green,
                    hintText: 'Address',
                    icon: Icon(Icons.email),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _typedAddress = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Enter Address';
                    return null;
                  },
                ),
                if (_typedTime != null) Text(_typedTime),
                DatePickerWid(setDate),
                TextButton(child: Text('Save'), onPressed: trySubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
