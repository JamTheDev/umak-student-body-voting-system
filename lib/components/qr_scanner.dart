import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrScanner extends StatefulWidget {
  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result?.code != null) {
          Navigator.pop(context, result!.code);
        }
      });
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "images/UMakBlueBG.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: _buildQrView(context),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Developed by Jam Emmanuel Villarosa",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "Metropolis",
                        fontSize: 12.spMin,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<T> scanQrCode<T>(BuildContext context) async {
  final returnedData = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => QrScanner()));
  return returnedData;
}
