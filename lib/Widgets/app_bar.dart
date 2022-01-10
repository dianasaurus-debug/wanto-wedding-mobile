import 'dart:convert';

import 'package:dream_wedding_app/Controllers/vendor.dart';
import 'package:dream_wedding_app/Screens/booking_list.dart';
import 'package:dream_wedding_app/Screens/detail_jasa_screen.dart';
import 'package:dream_wedding_app/Screens/jasa_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';


class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key? key, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            style: DefaultTextStyle.of(context).style.copyWith(
                fontWeight: FontWeight.bold
            ),
          decoration: InputDecoration(
            icon: Icon(CupertinoIcons.search, color: Color(0xff80cbc4)),
            border: InputBorder.none,
            hintText: 'Cari',
            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return await VendorNetwork().getCariVendor(pattern);
        },
        itemBuilder: (context, suggestion) {
          var suggestion_parse = (suggestion as Map);
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(suggestion_parse['nama']),
            subtitle: Text('${formatCurrency.format(int.parse(suggestion_parse['harga']))}'),
          );
        },
        onSuggestionSelected: (suggestion) {
          var detail_suggestion_parse = (suggestion as Map);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailJasa(idVendor: detail_suggestion_parse['id'])
          ));
        },
      ),


      // Container(
      //   decoration: BoxDecoration(
      //       color: Colors.white, borderRadius: BorderRadius.circular(20)),
      //   child: TextFormField(
      //     decoration: InputDecoration(
      //       icon: Icon(CupertinoIcons.search, color: Color(0xff80cbc4)),
      //       border: InputBorder.none,
      //       hintText: 'Cari',
      //       // contentPadding:
      //       //     EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      //     ),
      //   ),
      // ),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications_outlined,
                color: Color(0xff80cbc4)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingList()),
              );
            }),
        IconButton(
            icon: Icon(Icons.shopping_cart_outlined,
                color: Color(0xff80cbc4)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingList()),
              );
            }),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}