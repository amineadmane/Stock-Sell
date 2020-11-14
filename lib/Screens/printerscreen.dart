import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrinterPage extends StatefulWidget {
  static String id = '/printer';
  @override
  _PrinterPageState createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  final doc = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printer Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          doc.addPage(pw.Page(
              pageFormat: PdfPageFormat.roll57,
              build: (pw.Context context) {
                return pw.Column(children: [
                  pw.Text('lg1', style: pw.TextStyle(fontSize: 4)),
                  pw.Text('lg2')
                ]);
                // Center
              }));
          await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => doc.save());
        },
        child: Icon(Icons.search),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) => ListTile(
          onTap: () {
            printerManager.selectPrinter(_devices[position]);
            Ticket ticket = Ticket(PaperSize.mm58);
            ticket.text('Demo text');
            ticket.feed(1);
            ticket.cut();
            printerManager.printTicket(ticket).then((result) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(result.msg)));
            }).catchError((error) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          },
          title: Text(_devices[position].name),
          subtitle: Text(_devices[position].address),
        ),
        itemCount: _devices.length,
      ),
    );
  }
}
