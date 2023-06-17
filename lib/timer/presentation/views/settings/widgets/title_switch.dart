import 'package:flutter/material.dart';

import 'styled_switch.dart';

class TitleSwitch extends StatefulWidget {
  const TitleSwitch({
    super.key,
    required this.title,
    required this.onToggle,
  });

  final String title;
  final void Function(bool) onToggle;

  @override
  State<TitleSwitch> createState() => _TitleSwitchState();
}

class _TitleSwitchState extends State<TitleSwitch> {
  bool _switch = false;

  _onToggle() {
    setState(() {
      _switch = !_switch;
    });
    widget.onToggle(_switch);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onToggle,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.bodySmall),
            StyledSwitch(
              value: _switch,
              onToggle: (val) => _onToggle(),
            ),
          ],
        ),
      ),
    );
  }
}
