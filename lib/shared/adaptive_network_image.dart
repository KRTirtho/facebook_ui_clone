import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptiveNetworkImage extends StatefulWidget {
  final String src;
  final bool isAvatar;
  final int maxWidth;
  AdaptiveNetworkImage(this.src,
      {Key key, this.isAvatar = false, this.maxWidth})
      : super(key: key);

  @override
  _AdaptiveNetworkImageState createState() => _AdaptiveNetworkImageState();
}

class _AdaptiveNetworkImageState extends State<AdaptiveNetworkImage> {
  @override
  Widget build(BuildContext context) {
    var cachedNetworkImage = CachedNetworkImage(
      maxWidthDiskCache: widget.maxWidth,
      imageUrl: widget.src,
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage,
      placeholder: (context, url) => CircularProgressIndicator(),
    );
    if (widget.isAvatar) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(widget.src,
            maxWidth: widget.maxWidth,
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HtmlImage),
      );
    }
    return cachedNetworkImage;
  }
}
