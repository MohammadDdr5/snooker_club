import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          const Row(
            children: [TablesStopWatch()],
          ),
          ElevatedButton(onPressed: () {}, child: const Text('start')),
        ],
      ),
    );
  }
}

class TablesStopWatch extends StatefulWidget {
  const TablesStopWatch({super.key});

  @override
  State<TablesStopWatch> createState() => _TablesStopWatchState();
}

class _TablesStopWatchState extends State<TablesStopWatch> {
  static final StopWatchTimer _mystopwatchtimer = StopWatchTimer();
  final ishoures = true;
  @override
  void dispose() {
    _mystopwatchtimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            StreamBuilder<int>(
                stream: _mystopwatchtimer.rawTime,
                initialData: _mystopwatchtimer.rawTime.value,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displaytime =
                      StopWatchTimer.getDisplayTime(value!, hours: ishoures);

                  return Text(displaytime);
                }),
            ElevatedButton(
                onPressed: () {
                  _mystopwatchtimer.onExecute.add(StopWatchExecute.start);
                },
                child: const Text('Start')),
            ElevatedButton(
                onPressed: () {
                  _mystopwatchtimer.onExecute.add(StopWatchExecute.stop);
                },
                child: const Text("close"))
          ],
        )
      ],
    );
  }
}
