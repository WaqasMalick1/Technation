import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoItem extends StatefulWidget {
  final String imageUrl;
  const PhotoItem({
    @required this.imageUrl,
    Key key,
  }) : super(key: key);
  @override
  _PhotoItemState createState() => _PhotoItemState();
}

class _PhotoItemState extends State<PhotoItem> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      placeholder: (context, url) => Center(
        child: Container(
          color: Colors.grey[500],
        )
      ),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
      ),
    );
  }
}
