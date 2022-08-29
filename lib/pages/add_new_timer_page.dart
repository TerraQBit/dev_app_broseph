import 'package:flutter/material.dart';

class AddNewTimerPage extends StatefulWidget {

  VoidCallback onTap;

  AddNewTimerPage( this.onTap, {Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddNewTimerPageState();
}

class AddNewTimerPageState extends State<AddNewTimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEW TIMER'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              alignment: Alignment.center,
              color: Colors.redAccent,
              height: 70,
              width: MediaQuery.of(context).size.width-40,
              child: const Text('Start Random Timer'),
            ),
          ),
        ),
      ),
    );
  }
}

