import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:salaison_app/core/database/app_database.dart';

class PdfService {
  Future<void> generatePieceReport(Piece piece, List<Spice> spices, List<Weighing> weighings) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Fiche de Traçabilité', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.yellow700,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text('[${piece.physicalID ?? 'N/A'}]', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white)),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Produit : ${piece.nom}', style: pw.TextStyle(fontSize: 18)),
              pw.Text('Date de début : ${piece.dateDebut.toString().split(' ')[0]}'),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text('Ingrédients', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Bullet(text: 'Sel : ${piece.quantiteSel.toStringAsFixed(1)}g'),
              pw.Bullet(text: 'Sucre : ${piece.quantiteSucre.toStringAsFixed(1)}g'),
              ...spices.map((s) => pw.Bullet(text: '${s.nom} : ${s.quantite.toStringAsFixed(1)}g')),
              pw.SizedBox(height: 20),
              pw.Text('Objectifs', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text('Poids initial : ${piece.poidsInitial.toStringAsFixed(1)}g'),
              pw.Text('Poids cible (-35%) : ${piece.poidsCible.toStringAsFixed(1)}g'),
              pw.SizedBox(height: 20),
              pw.Text('Historique des Pesées', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.TableHelper.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Date', 'Poids (g)', 'Étape'],
                  ...weighings.map((w) => [w.date.toString().split(' ')[0], w.poids.toStringAsFixed(1), w.label ?? 'Séchage']),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
