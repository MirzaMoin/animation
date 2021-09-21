import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarAnimHome extends StatefulWidget {
  const CarAnimHome({Key? key}) : super(key: key);

  @override
  _CarAnimHomeState createState() => _CarAnimHomeState();
}

class _CarAnimHomeState extends State<CarAnimHome>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationControllerTop;
  late AnimationController animationControllerText;

  double topPosition = 200, bottomPosition = 250;
  bool isTap = false, isSignPressed = false, isFinish = false;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 800),
    );
    animationControllerTop = new AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 10.0,
      duration: Duration(milliseconds: 800),
    );
    animationControllerText = new AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(milliseconds: 800),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(color: Colors.black
            /*   gradient: LinearGradient(
              colors: [Color(0xff191462), Color(0xff513be9), Color(0xff241667)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),*/
            ),
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, snapshot) {
              final value = animationController.value;
              final select = lerpDouble(0.0, 2 * 3.14, value);
              return GestureDetector(
                onTap: () {
                  // animationController.reverse();
                  setState(() {
                    isTap = true;
                    animationControllerText.forward();
                  });
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..scale(value)
                    ..rotateY(select!),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: 160.0,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: isTap
                                  ? isSignPressed
                                      ? 0
                                      : 50
                                  : 0,
                              child: Text(
                                "HONDA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.abhayaLibre().fontFamily),
                              ),
                            )),

                        AnimatedPositioned(
                            top: 120,
                            duration: Duration(milliseconds: 500),
                            height: isFinish ? 0 : 400,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 50),
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    height: isTap
                                        ? isSignPressed
                                            ? 350
                                            : 0
                                        : 0,
                                    child: isSignPressed
                                        ? Image.asset(
                                            "assets/car_anim/faceidscanner.gif",
                                          )
                                        : Container(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Log in with Face ID",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: GoogleFonts.beVietnam()
                                                .fontFamily),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: Text(
                                          "Put your phone in front of\n your face to log in",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        isTap
                            ? AnimatedPositioned(
                                duration: Duration(seconds: 1),
                                bottom: isSignPressed
                                    ? isFinish
                                        ? 300
                                        : 0
                                    : 200,
                                left: isSignPressed ? -100 : 0,
                                child: AnimatedContainer(
                                    color: Colors.red,
                                    height: 300,
                                    transform: Matrix4.identity()
                                      ..scale(isSignPressed ? 1.5 : 1.0),
                                    duration: Duration(seconds: 1),
                                    child: AnimatedPositioned(
                                      duration: Duration(seconds: 3),
                                      child: Image.asset(
                                        "assets/car_anim/cargif.gif",
                                        alignment: Alignment.center,
                                      ),
                                    )),
                              )
                            : Container(),
                        Positioned(
                            top: 120.0,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: isFinish ? 200 : 0,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "YOUR VEHICLE",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.rajdhani().fontFamily,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "NSX",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 120,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: GoogleFonts.abhayaLibre()
                                              .fontFamily,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        //Logo Code
                        AnimatedPositioned(
                          height: isTap
                              ? isSignPressed
                                  ? isFinish
                                      ? 0
                                      : 50.0
                                  : 80.0
                              : 200.0,
                          top: isTap ? 50.0 : size.height / 3,
                          right: 0,
                          left: 0,
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.fastOutSlowIn,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isTap = true;
                              });
                            },
                            child: Image.asset(
                              "assets/car_anim/logo.png",
                              height: 200,
                            ),
                          ),
                        ),

                        //Button Code
                        AnimatedPositioned(
                            bottom: 0,
                            width: size.width,
                            height: isSignPressed ? 0 : 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 20),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 1500),
                                      width: isTap ? size.width : 0,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xffffffff),
                                            Color(0xffffffff),
                                            Color(0xffffffff)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          boxShadow: isTap
                                              ? [
                                                  BoxShadow(
                                                    color: Color(0xffffffff),
                                                    spreadRadius: 2,
                                                    blurRadius: 15,
                                                  )
                                                ]
                                              : []),
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            Future.delayed(Duration(seconds: 5),
                                                () {
                                              setState(() {
                                                isFinish = true;
                                              });
                                            });
                                            isSignPressed = true;
                                          });
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        color: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 20),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 1500),
                                      width: isTap ? size.width : 0,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        child: Text(
                                          "SIGNUP",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        color: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 300)),
                        AnimatedPositioned(
                            bottom: 0,
                            width: isFinish ? size.width : 0,
                            height: isFinish ? 100 : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        boxShadow: isTap
                                            ? [
                                                BoxShadow(
                                                  color: Color(0xffffffff),
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                )
                                              ]
                                            : []),
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          Future.delayed(Duration(seconds: 5),
                                              () {
                                            setState(() {
                                              isFinish = true;
                                            });
                                          });
                                          isSignPressed = true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/car_anim/logo.png",
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "MY CAR",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    GoogleFonts.beVietnam()
                                                        .fontFamily,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      color: Colors.transparent,
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Icon(
                                    Icons.addchart_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                Flexible(
                                  child: Icon(
                                    Icons.add_business_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                Flexible(
                                  child: Icon(
                                    Icons.add_box_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                Flexible(
                                  child: Icon(
                                    Icons.account_circle_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 500))
                      ],
                    ),
                  ),
                ),
              );
            }),
      )),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
