import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snookerclub/classes/textstyle.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SingleTable extends StatelessWidget {
  const SingleTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Table'),
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 50,
            top: 20,
            right: 50,
          ),
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('table name', style: Textstyles.redtextstyle),
                    Text('price', style: Textstyles.redtextstyle),
                    Text('status', style: Textstyles.redtextstyle),
                    Text('time', style: Textstyles.redtextstyle),
                  ],
                ),
                Column(
                  children: [
                    Text('table name', style: Textstyles.blackstyle),
                    Text('price', style: Textstyles.blackstyle),
                    Text('status', style: Textstyles.blackstyle),
                  ],
                )
              ],
            ),
            Stopwatch(),
          ]),
        ),
      ),
    );
  }
}

class Stopwatch extends StatelessWidget {
  Stopwatch({super.key});
  final bool ishoures = true;
  final StopWatchTimer stopwatchtimer2 = StopWatchTimer();
  var timeforcalculate;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Column(
          children: [
            StreamBuilder<int>(
                stream: stopwatchtimer2.rawTime,
                initialData: stopwatchtimer2.rawTime.value,
                builder: (context, snapshot) {
                  var value = snapshot.data;
                  var displaytime =
                      StopWatchTimer.getDisplayTime(value!, hours: ishoures);
                  timeforcalculate = displaytime;
                  return Text(displaytime);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    stopwatchtimer2.onExecute.add(StopWatchExecute.start);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    stopwatchtimer2.onExecute.add(StopWatchExecute.stop);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: () {
                    stopwatchtimer2.onExecute.add(StopWatchExecute.reset);
                    print(timeforcalculate);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text('Stop and Calculate and Reset'),
                ),
              ],
            )
          ],
        ));
  }
}
