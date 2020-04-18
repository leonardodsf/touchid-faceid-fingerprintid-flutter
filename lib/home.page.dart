import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:touchid/details.page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _localAuthentication.canCheckBiometrics;
      return isAvailable;
    } catch (err) {
      return false;
    }
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
  }

  Future<void> _authenticateUser() async {
    bool isAutheticated = await _localAuthentication.authenticateWithBiometrics(
      localizedReason: "Use a biometria para prosseguir",
      useErrorDialogs: true,
      stickyAuth: true,
    );
    if (isAutheticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autentique-se"),
      ),
      body: Container(
        child: Center(
          child: Text("Use a digital para prosseguir"),
        ),
      ),
    );
  }
}
