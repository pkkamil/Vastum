import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class Search extends StatefulWidget {
  const Search({ Key key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = new TextEditingController();
  bool isLoading = true;
  var records;

  void getData() async{
    String url = "https://api.um.warszawa.pl/api/action/datastore_search/?resource_id=64b9d66c-d134-4a87-9f24-258676e9e498";
    Response response = await get(Uri.parse(url));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      setState(() {
      records = data['result']['records'];
    });
    }
    if(records!=null){
      isLoading=false;
    }
  }
  
  void setupData() async{
    await getData();
  }

  @override
  void initState(){
    // TODO: implement initState
    setupData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    if(isLoading){
        return Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 100.0,
            ),
          )
        );
    }else{
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(
              "Wyszukaj"
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30
                  ),
                  Container(
                    width: size.width*0.8,
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        hintText: 'np. butelka',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightGreen),
                        ),
                        fillColor: Colors.green
                      ),
                      style: TextStyle(
                        fontSize: 25
                      ),
                      onChanged: (string) async{
                        String url = "https://api.um.warszawa.pl/api/action/datastore_search/?resource_id=64b9d66c-d134-4a87-9f24-258676e9e498&q=$string";
                        Response response = await get(Uri.parse(url));
                        if(response.statusCode==200){
                          var data = jsonDecode(response.body);
                          setState(() {
                            records = data['result']['records'];
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  if(records!=null) for(int i=0;i<records.length;i++) Container(
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              records[i]['Nazwa'],
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                            Text(
                              records[i]['Typ'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    width: size.width*0.9,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  )
                ],
              ),
            ),
          )
        ),
      );
    }
  }
}