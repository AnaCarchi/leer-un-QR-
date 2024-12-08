import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scanner {
  Future<String> startScanning(bool isQrMode) async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancelar",
        true,
        isQrMode ? ScanMode.QR : ScanMode.BARCODE,
      );
      if (barcodeScanRes == "-1") {
        return "Escaneo cancelado";
      }
      return barcodeScanRes;
    } catch (e) {
      return "Error al escanear: $e";
    }
  }
}
