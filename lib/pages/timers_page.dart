import 'dart:async';
import 'dart:math';

import 'package:dev_app_broseph/pages/add_new_timer_page.dart';
import 'package:flutter/material.dart';

class TimersPage extends StatefulWidget {
  const TimersPage({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimersPageState();
}

class TimersPageState extends State<TimersPage> {
  var timers = [];
  var timerNum = [];
  var cout = 0;
  var coutNow = 0;
  var dis = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(225, 222, 222, 1.0),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cout,
              itemBuilder: (BuildContext context, int index) {
                return TimerElement(index, cout, coutNow, dis, () => {
                  setState(() {
                    coutNow = coutNow - 1;
                    dis += 1;
                  })
                });
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: $coutNow', style: const TextStyle(fontSize: 20)),
                  GestureDetector(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.red
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTimerPage(
                          () => {
                            setState(() {
                              cout += 1;
                              coutNow += 1;
                            })
                          }
                      )),
                      );
                    },
                    onDoubleTap: () {
                    },
                  )
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}

class TimerElement extends StatefulWidget {

  var index;
  var cout;
  var coutNow;
  var dis;
  VoidCallback onTimerIsEnd;

  TimerElement(this.index, this.cout, this.coutNow, this.dis, this.onTimerIsEnd, {Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimerElementState();
}

class TimerElementState extends State<TimerElement> {

  late Timer timer;
  late int number = widget.cout;
  bool isNull = true;
  late ValueNotifier<int> sec = ValueNotifier(Random().nextInt(60));

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (widget.index-widget.dis <= 3) {
        setState(() {
          sec.value -= 1;
        });
      }
    });
    sec.addListener(() {
      if (sec.value <= 0) {
        isNull = false;
        timer.cancel();
        widget.onTimerIsEnd();
      }
      //print('индекс: ${widget.index} секунды: ${sec.value}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isNull ?
    Column(
      children: [
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Timer $number'),
                widget.index-widget.dis <= 3 ? Text('${sec.value} sec') : const Text('pause')
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(height: 20, color: Colors.redAccent,  thickness: 2,),
        )
      ]
    ) : const SizedBox();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

}

