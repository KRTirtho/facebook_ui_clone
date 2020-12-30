import 'package:flutter/material.dart';

class PopupMenuItemChild extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const PopupMenuItemChild(
      {Key key, @required this.icon, @required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> textList = [Text(title)];
    if (subtitle != null) {
      textList.add(Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(subtitle,
            style: TextStyle(color: Colors.grey[700], fontSize: 12)),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: textList,
          ),
        )
      ],
    );
  }
}
