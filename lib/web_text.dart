import 'package:flutter/material.dart';

import 'dart:html' as html;
import 'dart:ui' as ui;

class WebText extends StatefulWidget {
  const WebText(this.data, {Key? key, this.style}) : super(key: key);

  final String data;
  final TextStyle? style;

  @override
  State<WebText> createState() => _WebTextState();
}

class _WebTextState extends State<WebText> {
  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('h1', (int viewId) {
      final html.Element htmlElement = html.HeadingElement.h1()
        ..text = 'HELLO MUNDO V2'
        ..style.width = '100%'
        ..style.height = '100%';

      return htmlElement;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          widget.data,
          style: widget.style,
        ),
        const Positioned.fill(
          child: Opacity(
            opacity: 0.002,
            child: HtmlElementView(viewType: 'h1'),
          ),
        ),
      ],
    );
  }
}
