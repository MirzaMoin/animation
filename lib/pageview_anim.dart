import 'dart:ui';

import 'package:flutter/material.dart';

class PageViewAnim extends StatefulWidget {
  const PageViewAnim({Key? key}) : super(key: key);

  @override
  _PageViewAnimState createState() => _PageViewAnimState();
}

class _PageViewAnimState extends State<PageViewAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  PageController pageController = new PageController();
  double currentPage = 0.0;
  double height = 0;
  bool isExpanded = false;
  double _minHeight = 70.0, _maxHeight = 350.0;
  double currentHeight = 70.0;

  listener() {
    setState(() {
      currentPage = pageController.page!;
      print("Current page $currentPage");
    });
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    pageController.addListener(listener);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  late double manuWidth;
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    manuWidth = size.width * 0.5;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 400,
            child: PageView.builder(
                controller: pageController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  final percent = (currentPage - index);
                  final value = percent.clamp(0.0, 1.0);
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateY(3.14 * value),
                      child: Container(
                        child: Image.asset(
                          "assets/${index + 1}.png",
                          fit: BoxFit.fitWidth,
                          height: 20,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: GestureDetector(
          onVerticalDragUpdate: isExpanded
              ? (details) {
                  setState(() {});
                }
              : null,
          onVerticalDragEnd: (details) {},
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
            if (isExpanded) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, snapshot) {
                final value = animationController.value;
                return Stack(
                  children: [
                    Positioned(
                      height: lerpDouble(_minHeight, _maxHeight, value),
                      left:
                          lerpDouble(size.width / 2 - manuWidth / 2, 0, value),
                      width: lerpDouble(manuWidth, size.width, value),
                      bottom: lerpDouble(40.0, 0.0, value),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(
                              20,
                            ),
                          ),
                          color: Colors.red,
                        ),
                        child: isExpanded ? Container() : buildMenuContent(),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget buildMenuContent() {
    return Positioned(
      height: _minHeight,
      bottom: 40,
      left: size.width / 2 - manuWidth / 2,
      width: manuWidth,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.stop,
              color: Colors.white,
              size: 35,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (height == 0)
                    height = 300;
                  else
                    height = 0;
                });
              },
              child: Icon(
                Icons.play_arrow,
                color: Colors.green,
                size: 35,
              ),
            ),
            Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
