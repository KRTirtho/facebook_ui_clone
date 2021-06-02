import 'package:facebookui/shared/adaptive_network_image.dart';
import 'package:flutter/material.dart';

class CardBody extends StatefulWidget {
  final String description;
  final String media;
  CardBody({Key key, @required this.description, this.media}) : super(key: key);

  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  String description;

  bool isLongDescription = false;

  @override
  void initState() {
    super.initState();
    description = widget.description;
    if (widget.description.length > 100) {
      isLongDescription = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // descriptions text
        TextButton(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  isLongDescription
                      ? description.substring(0, 100)
                      : description,
                  style: TextStyle(color: Colors.black))),
          onPressed: () {
            if (isLongDescription) {
              setState(() {
                isLongDescription = !isLongDescription;
              });
            }
          },
        ),
        // image
        if (widget.media != null) AdaptiveNetworkImage(widget.media)
      ],
    );
  }
}
