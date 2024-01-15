import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void generatePdf(Map<String, dynamic> data) async {
  final pdf = pw.Document();

  pdf.addPage(pw.MultiPage(
    build: (context) => [
      pw.TableHelper.fromTextArray(
        border: null,
        cellPadding: pw.EdgeInsets.all(8),
        headerDecoration: pw.BoxDecoration(
          color: PdfColors.grey200,
        ),
        headers: [
          'Field',
          'Value',
        ],
        data: [
          ['Admin Notes', data['Admin Notes']],
          ['Assigned Orders', data['Assigned Orders']],
          ['Customer Contact', data['Customer Contact']],
          ['Customer ID', data['Customer ID']],
          ['Customer Name', data['Customer Name']],
          ['Delivery Address', data['Delivery Address']],
          ['Order Date and Time', data['Order Date and Time']],
          ['Order ID', data['Order ID']],
          ['Order Status', data['Order Status']],
          ['Order Total', data['Order Total']],
          ['Payment Method', data['Payment Method']],
          ['Payment Status', data['Payment Status']],
        ],
      ),
    ],
  ));

  // Save the PDF as bytes
  final file = File(await getFilePath());
  await file.writeAsBytes(await pdf.save());

  // Open the PDF using open_file package
  await OpenFilex.open(file.path);
  print('PDF created successfully.');
}

Future<String> getFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/order_history.pdf';
}
