import 'package:animation/3DCardAnimation/3d_card_home.dart';
import 'package:animation/3DCardAnimation/cards.dart';
import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({required this.card, Key? key}) : super(key: key);
  final Card3D card;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black45),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Align(
                child: SizedBox(
                    height: 150.0,
                    child: Hero(
                        tag: card.title, child: Card3DWidget(card: card)))),
            SizedBox(
              height: 20.0,
            ),
            Text(
              card.auther,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              card.title,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
