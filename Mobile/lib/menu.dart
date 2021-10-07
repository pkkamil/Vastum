import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ Key key }) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool isImage = false;
  File image;

  void getImage() async {
      final picker = new ImagePicker();
      var pickedFile = await picker.getImage(
        source: ImageSource.camera,
        maxHeight: 224,
        maxWidth: 224
      );
      setState(() {
        isImage=true;
        image = File(pickedFile.path);
      });
      modelPredict(image);
    }

    void modelPredict(File image) async{
      var result = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 127.5,   
        imageStd: 127.5,    
        numResults: 1,      
        threshold: 0.1,     
        asynch: true  
      );
      String title = result[0]['label'].substring(2);
      var confidence = result[0]['confidence']*100;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(
              "Wykryto: $title"
            ),
            content: Text(
              "Poprawność: ${confidence.toStringAsFixed(2)}%"
            ),
        )
      );
    }

    void loadModel() async{
      var model = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt"
      );
      print(model);
    }

    @override
    void initState() {
      super.initState();
      loadModel();
    }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.green.withOpacity(0.7), BlendMode.darken),
            image: AssetImage('assets/ekran_glowny_tlo.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          height: size.height*0.6,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vastum",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Horizon',
                    fontSize: 70
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                    pause: Duration(milliseconds: 2000),
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText('Dbaj o planetę'),
                      TypewriterAnimatedText('Segreguj śmieci'),
                    ]
                  ),
                ),
                SizedBox(
                  height: size.height*0.15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.lightGreen,
                    width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                      color: Colors.lightGreen.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      ),
                    ],

                  ),
                  child:FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      onPressed: (){
                        Navigator.pushNamed(context, '/search');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5
                          ),
                          Text(
                            "Wyszukaj",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25
                            ),
                          )
                        ],
                      )
                    ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.lightGreen,
                    width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                      color: Colors.lightGreen.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      ),
                    ],

                  ),
                  child:FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      onPressed: (){
                        getImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5
                          ),
                          Text(
                            "Zeskanuj",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25
                            ),
                          )
                        ],
                      )
                    ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}