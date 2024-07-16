import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LearnSelectionScreen extends StatelessWidget {
  final List<String> pdfTitles = [
    'PDF 1', 'PDF 2', 'PDF 3', 'PDF 4',
    'PDF 5', 'PDF 6', 'PDF 7', 'PDF 8',
  ];

  final List<String> pdfPaths = [
    'assets/pdf/pdf1.pdf', 'assets/pdf/pdf2.pdf', 'assets/pdf/pdf3.pdf', 'assets/pdf/pdf4.pdf',
    'assets/pdf/pdf5.pdf', 'assets/pdf/pdf6.pdf', 'assets/pdf/pdf7.pdf', 'assets/pdf/pdf8.pdf',
  ];

  final List<String> pdfImages = [
    'assets/images/pdf.jpg', 'assets/images/pdf.jpg', 'assets/images/pdf.jpg', 'assets/images/pdf.jpg',
    'assets/images/pdf.jpg', 'assets/images/pdf.jpg', 'assets/images/pdf.jpg', 'assets/images/pdf.jpg',
  ];

  void _openPDF(BuildContext context, String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFViewerScreen(pdfPath: pdfPath)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn More'),
      ),
      backgroundColor: Colors.purple[400], // Set background color
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: pdfTitles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _openPDF(context, pdfPaths[index]),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    pdfImages[index],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    pdfTitles[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PDFViewerScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
        enableDoubleTapZooming: true,
        canShowScrollStatus: true,
        pageLayoutMode: PdfPageLayoutMode.continuous, // Set continuous page layout
        scrollDirection: PdfScrollDirection.vertical, // Set vertical scrolling
      ),
    );
  }
}
