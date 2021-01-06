import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdaptiveNetworkImage extends StatefulWidget {
  final String src;
  final isAvatar;
  AdaptiveNetworkImage(this.src, {Key key, this.isAvatar = false})
      : super(key: key);

  @override
  _AdaptiveNetworkImageState createState() => _AdaptiveNetworkImageState();
}

class _AdaptiveNetworkImageState extends State<AdaptiveNetworkImage> {
  Uint8List _srcBytes;
  bool isWeb = kIsWeb;

  @override
  void initState() {
    super.initState();
    if (isWeb) {
      _fetchForWeb();
    }
  }

  void _fetchForWeb() async {
    _srcBytes = (await http.get(widget.src)).bodyBytes;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildMemoryImageFrame(BuildContext _, Widget child, int __,
      bool ___) {
    return Container(
      constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isWeb && _srcBytes != null) {
      return Image.memory(_srcBytes,
          frameBuilder: widget.isAvatar ? _buildMemoryImageFrame : null);
    }
    return CachedNetworkImage(
      imageUrl: widget.src,
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
      placeholder: (context, url) => CircularProgressIndicator(),
    );
  }
}
