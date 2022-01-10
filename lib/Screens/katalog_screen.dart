import 'dart:async';
import 'dart:io';

import 'package:dream_wedding_app/Controllers/katalog.dart';
import 'package:dream_wedding_app/Controllers/kategori.dart';
import 'package:dream_wedding_app/Models/katalog.dart';
import 'package:dream_wedding_app/Models/tema.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:dream_wedding_app/Widgets/katalog_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';


class KatalogScreen extends StatefulWidget {
  @override
  _KatalogScreenState createState() => _KatalogScreenState();
}
class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
class _KatalogScreenState extends State<KatalogScreen> {
  late Future<List<Katalog>> futureKatalog;
  late Future<List<Tema>> futureTema;
  List<Katalog> usedKatalog = [];
  List<Tema> usedTema = [];
  final _debouncer = Debouncer();

  @override
  void initState() {
    futureKatalog = KatalogNetwork().getKatalog();
    futureTema = CategoryNetwork().getAllTema();
  }
  var idSelected = 0;



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Katalog',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              icon:
                  Icon(Icons.notifications_outlined, color: Color(0xff80cbc4)),
              onPressed: () {}),
          IconButton(
              icon:
                  Icon(Icons.shopping_cart_outlined, color: Color(0xff80cbc4)),
              onPressed: () {}),
        ],
      ),
      body: Container(
          padding : EdgeInsets.all(12),
          child: FutureBuilder<List<Katalog>>(
              future: futureKatalog,
              builder: (context, katalog) {
                if (katalog.hasData) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    ///This schedules the callback to be executed in the next frame
                    /// thus avoiding calling setState during build
                    setState(() {
                      if(idSelected==0){
                        usedKatalog = katalog.data!;
                      }
                    });
                  });
                   return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : [
                        FutureBuilder<List<Tema>>(
                            future: futureTema,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                                  ///This schedules the callback to be executed in the next frame
                                  /// thus avoiding calling setState during build
                                  setState(() {
                                    if(usedTema.length==0){
                                      setState(() {
                                          usedTema = snapshot.data!;
                                          usedTema.add(new Tema("Semua", 0));
                                      });
                                    }
                                  });
                                });
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Jenis Katalog', style: TextStyle(fontSize : 18, fontWeight : FontWeight.bold)),
                                    Wrap(
                                      children: snapshot.data!.map((e) => ChoiceChip(
                                        label: Text(e.nama_tema),
                                        selected: idSelected == e.id,
                                        onSelected: (bool selected) {
                                          setState((){
                                            idSelected = e.id;
                                          });
                                            if(idSelected!=0){
                                              setState(() {
                                                usedKatalog = katalog.data!.where((data) => data.tema_id == idSelected).toList();
                                              });
                                            } else {
                                              setState(() {
                                                usedKatalog = katalog.data!;
                                              });
                                            }

                                        }
                                      )).toList(),
                                      spacing: 8,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            }),
                    SizedBox(
                      height: 10
                    ),
                    KatalogElement(usedKatalog: usedKatalog)
                    ]
                  );
                } else if (katalog.hasError) {
                  return Text("${katalog.error}");
                }
                return CircularProgressIndicator();
              })

      ));
  }
}

class ItemChoice {
  final int id;
  final String label;

  ItemChoice(this.id, this.label);
}
