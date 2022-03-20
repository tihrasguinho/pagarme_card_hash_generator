import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WebImage extends StatefulWidget {
  const WebImage.network(
    this.data, {
    Key? key,
    this.viewType,
    this.alt,
    this.width,
    this.height,
    this.blendMode,
    this.boxFit,
    this.scale = 1.0,
  })  : isAsset = false,
        super(key: key);

  const WebImage.asset(
    this.data, {
    Key? key,
    this.viewType,
    this.alt,
    this.width,
    this.height,
    this.blendMode,
    this.boxFit,
    this.scale = 1.0,
  })  : isAsset = true,
        super(key: key);

  final String data;
  final String? viewType;
  final String? alt;

  final double? width;
  final double? height;
  final BlendMode? blendMode;
  final BoxFit? boxFit;
  final double scale;

  final bool isAsset;

  @override
  State<WebImage> createState() => _WebImageState();
}

class _WebImageState extends State<WebImage> {
  late String _viewType;

  @override
  void initState() {
    _viewType = widget.viewType ?? 'IMG-${DateTime.now().toIso8601String()}';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final html.Element image = html.ImageElement()
        ..src = widget.isAsset ? './assets/${widget.data}' : widget.data
        ..alt = widget.alt
        ..className = 'flutter-images'
        ..style.width = '100%'
        ..style.height = '100%';
      return image;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.isAsset
            ? Image.asset(
                widget.data,
                width: widget.width,
                height: widget.height,
                scale: widget.scale,
                colorBlendMode: widget.blendMode,
                fit: widget.boxFit,
              )
            : Image.network(
                widget.data,
                width: widget.width,
                height: widget.height,
                scale: widget.scale,
                colorBlendMode: widget.blendMode,
                fit: widget.boxFit,
              ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.002,
            child: HtmlElementView(
              viewType: _viewType,
            ),
          ),
        ),
      ],
    );
  }
}
