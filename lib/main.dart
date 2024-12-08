import 'package:flutter/material.dart';
import 'scanner.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple[200],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink[100]),
      ),
      home: ScannerPage(),
    );
  }
}

class ScannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Escáner QR y de Barras",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.purple[200],
      ),
      body: Container(
        color: Colors.pink[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[200], 
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanScreen(isQrMode: true)),
                );
              },
              icon: Icon(Icons.qr_code, color: Colors.black),
              label: Text("Escanear QR"),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[200], 
                foregroundColor: Colors.black, 
              ),
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanScreen(isQrMode: false)),
                );
              },
              icon: Icon(Icons.bar_chart, color: Colors.black),
              label: Text("Escanear Código de Barras"),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanScreen extends StatefulWidget {
  final bool isQrMode;
  ScanScreen({required this.isQrMode});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final Scanner scanner = Scanner();
  String scanResult = "Escaneando...";

  @override
  void initState() {
    super.initState();
    _startScanning();
  }

 
  Future<void> _startScanning() async {
    String result = await scanner.startScanning(widget.isQrMode);
    if (!mounted) return;
    setState(() {
      scanResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isQrMode ? "Escáner QR" : "Escáner Código de Barras",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.purple[200],
      ),
      body: Container(
        color: Colors.pink[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.isQrMode ? Icons.qr_code_scanner : Icons.bar_chart,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              scanResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[200], 
                foregroundColor: Colors.black, 
              ),
              onPressed: () {
                
                setState(() {
                  scanResult = "Escaneando...";
                });
                _startScanning();
              },
              icon: Icon(Icons.camera_alt, color: Colors.black),
              label: Text("Escanear de nuevo"),
            ),
          ],
        ),
      ),
    );
  }
}
