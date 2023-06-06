import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents Homepage for Navigation
class HowToPlay extends StatefulWidget {
  @override
  _HowToPlay createState() => _HowToPlay();
}

class _HowToPlay extends State<HowToPlay> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Read & Learn'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _pdfViewerController.zoomLevel  +=0.25;
                },
                icon: Icon(Icons.zoom_in, color: Colors.white,)),
            IconButton(
                onPressed: () {
                  _pdfViewerController.zoomLevel  -=0.25;
                },
                icon: Icon(Icons.zoom_out, color: Colors.white,)),
          ],
        ),
        body: SfPdfViewer.asset(
          'assets/pdf/HowToPlay.pdf',
          controller: _pdfViewerController,
        ),

      ),
    );
  }
}
