// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pomodoro_timer/timer/presentation/widgets/styled_container.dart';

import 'sounds.dart';
import 'timer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _tabs = ['Timer', 'Sounds', 'Something'];
  double heightContainer = 500;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                StyledContainer(
                  child: TabBar(
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
                    indicator: BoxDecoration(
                      color: Colors.black,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    tabs: _tabs
                        .map(
                          (e) => Tab(
                            text: e,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Flexible(
                  // height: heightContainer,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: StyledContainer(
                      child: TabBarView(
                        children: const [
                          TimerSettings(),
                          SoundsSetting(),
                          Placeholder(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
