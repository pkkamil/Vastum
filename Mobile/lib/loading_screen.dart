import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _LoadingState extends State<Loading> {
  

  void checkConn() async{
    String url = "https://api.um.warszawa.pl/api/action/datastore_search/?resource_id=64b9d66c-d134-4a87-9f24-258676e9e498";
    try{
      Response response = await get(Uri.parse(url));
      if(response.statusCode==200){
        Navigator.pushReplacementNamed(context, '/mainmenu');
      }
    }
    catch(e){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            duration: Duration(seconds: 10),
            backgroundColor: Colors.lightGreen,
              content: Text(
                'Brak połączenia z internetem',
                 textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18
                ),
              )
          )
        );
      print("Wystąpił błąd");
    }
  }
  @override
  void initState() {
    super.initState();
    checkConn();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.green,
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}