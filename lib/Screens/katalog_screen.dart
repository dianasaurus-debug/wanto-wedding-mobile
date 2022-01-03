import 'dart:io';

import 'package:dream_wedding_app/Controllers/katalog.dart';
import 'package:dream_wedding_app/Models/katalog.dart';
import 'package:dream_wedding_app/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class KatalogScreen extends StatefulWidget {
  @override
  _KatalogScreenState createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  late Future<List<Katalog>> futureKatalog;
  @override
  void initState() {
    futureKatalog = KatalogNetwork().getKatalog();
  }

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Katalog', style: TextStyle(color: Colors.black),),
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
        margin: EdgeInsets.all(12),
        child:
        FutureBuilder<List<Katalog>>(
    future: futureKatalog,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return
                Container(
                    height: MediaQuery.of(context).size.height * 0.3, // ignore this, cos I am giving height to the container
                    width: MediaQuery.of(context).size.width * 0.5, // ignore this, cos I am giving width to the container
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(IMG_URL_KATALOG+snapshot.data![index].cover)
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                            Radius.circular(15))
                    ),
                    alignment: Alignment.bottomCenter, // This aligns the child of the container
                    child: Container(
                        width: double.infinity,
                        decoration :BoxDecoration(
                            color: Color(0xff80cbc4),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                        ),
                        padding: EdgeInsets.all(10.0), //some spacing to the child from bottom
                        child: Text('${snapshot.data![index].judul}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                    )
                );
              //   Container(
              //   decoration: BoxDecoration(
              //       color: Colors.transparent,
              //       borderRadius: BorderRadius.all(
              //           Radius.circular(15))
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(15)),
              //     child: FadeInImage.memoryNetwork(
              //       placeholder: kTransparentImage,
              //       image: imageList[index],fit: BoxFit.cover,),
              //   ),
              // );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }
            );
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
    })

      ),
    );
  }
}
