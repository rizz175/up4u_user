import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatefulWidget {
  String imageUrl;

  ImagePreview(this.imageUrl);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: PhotoView(
      imageProvider: NetworkImage(widget.imageUrl),
    )));
  }
}
