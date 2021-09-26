import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:test_printing/data.dart';

Future<void> printLabel() async {
  Map dataLabel = data();
  await Printing.layoutPdf(onLayout: (format) => _generatePdf(dataLabel));
}

Future<Uint8List> _generatePdf(Map data) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  pw.TextStyle st = pw.TextStyle(fontSize: 6);
  //var formatter = new DateFormat('dd MM yyyy');
  //String formattedDate = formatter.format(new DateTime.now());
  //String formattedDate = formatter.format(new DateFormat().parse(data['date']));

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll57,
      build: (context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text("CITY COURIER", style: st),
                  pw.Text(data['date'].toString(), style: st)
                ]),
            //pw.Flexible(child: pw.FlutterLogo()),
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(height: 5),
                  pw.Container(
                      width: 65,
                      height: 65,
                      color: PdfColor.fromRYB(0.2, 0.2, 0.2)),
                  pw.SizedBox(height: 5),
                  pw.Text(data['id'], style: st),
                ]),
            pw.SizedBox(height: 10),
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Penerima", style: st),
                  pw.Text("Derman", style: st),
                  pw.Text("Jln AH Nasution No. 50", style: st),
                  pw.Text("Bandarlampung", style: st),
                  pw.Text("081225256686", style: st),
                  pw.SizedBox(height: 5),
                  pw.Text("Pengirim", style: st),
                  pw.Text("Handai", style: st),
                  pw.Text("083512125688", style: st),
                ]),
            pw.SizedBox(height: 10),
            pw.Table(border: pw.TableBorder.all(), children: <pw.TableRow>[
              pw.TableRow(children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(3),
                  child: pw.Text("Barang", style: st),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(3),
                  child: pw.Text("Berat (Kg)", style: st),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(3),
                  child: pw.Text("Kecamatan", style: st),
                ),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                  padding:
                      pw.EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
                  child: pw.Text("Gundam", style: st),
                ),
                pw.Padding(
                  padding:
                      pw.EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
                  child: pw.Text("2,5Kg", style: st),
                ),
                pw.Padding(
                  padding:
                      pw.EdgeInsets.symmetric(vertical: 1.5, horizontal: 3),
                  child: pw.Text("Kedaton", style: st),
                ),
              ])
            ])
          ],
        );
      },
    ),
  );

  return pdf.save();
}
