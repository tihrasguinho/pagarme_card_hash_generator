import 'package:flutter/material.dart';

import 'dart:html' as html;
import 'dart:ui' as ui;

class AdRenderer extends StatefulWidget {
  const AdRenderer({Key? key}) : super(key: key);

  @override
  State<AdRenderer> createState() => _AdRendererState();
}

class _AdRendererState extends State<AdRenderer> {
  @override
  void initState() {
    html.document.head!.append(html.ScriptElement()
      ..async = true
      ..src = 'https://securepubads.g.doubleclick.net/tag/js/gpt.js');

    html.document.head!.append(html.ScriptElement()
      ..text = '''
window.googletag = window.googletag || {cmd: []};
  googletag.cmd.push(function() {
    googletag
        .defineSlot(
            '/6355419/Travel/Europe/France/Paris', [300, 250], 'banner-ad')
        .addService(googletag.pubads());
    googletag.enableServices();
  });
''');

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('googleads', (int viewId) {
      final html.Element htmlElement = html.DivElement()
        ..id = 'banner-ad'
        ..style.width = '300px'
        ..style.height = '250px'
        ..append(html.ScriptElement()
          ..text = '''
googletag.cmd.push(function() {
          googletag.display('banner-ad');
        });
''');

      return htmlElement;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 250,
      child: HtmlElementView(viewType: 'googleads'),
    );
  }
}
