import 'package:dream_wedding_app/Screens/booking_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key? key, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(CupertinoIcons.search, color: Color(0xff80cbc4)),
            border: InputBorder.none,
            hintText: 'Cari',
            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          ),
        ),
      ),
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