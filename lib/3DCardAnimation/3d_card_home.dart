import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '3d_card_detail.dart';
import 'cards.dart';

class DCardHome extends StatefulWidget {
  const DCardHome({Key? key}) : super(key: key);

  @override
  _DCardHomeState createState() => _DCardHomeState();
}

class _DCardHomeState extends State<DCardHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "My Playlist",
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(flex: 3, child: CardBody()),
            Expanded(flex: 2, child: CardsHorizontal())
          ],
        ));
  }
}

class CardBody extends StatefulWidget {
  const CardBody({Key? key}) : super(key: key);

  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> with TickerProviderStateMixin {
  bool isSelectedMode = false;
  late AnimationController animationController;
  late AnimationController animationControllerMovement;
  late int selectedIndex = -1;
  Future<void> _onCardSelected(Card3D card, int index) async {
    setState(() {
      selectedIndex = index;
    });
    final duration = Duration(milliseconds: 750);
    animationControllerMovement.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: CardDetails(
            card: card,
          ),
        ),
      ),
    );
    animationControllerMovement.reverse(from: 1.0);
  }

  int getCurrentFactor(int index) {
    if (selectedIndex == -1 || index == selectedIndex) {
      return 0;
    } else if (index > selectedIndex) {
      return -1;
    } else {
      return 1;
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.15,
        upperBound: 0.5,
        duration: Duration(milliseconds: 500));

    animationControllerMovement = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 880));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationControllerMovement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
          animation: animationController,
          builder: (context, snapshot) {
            final selection = animationController.value;
            print("Animation Controller Value : $selection");
            return GestureDetector(
              onTap: () {
                print("selected Mode $isSelectedMode");
                if (!isSelectedMode) {
                  animationController.forward().whenComplete(() => () {});
                  setState(() {
                    isSelectedMode = true;
                  });
                } else {
                  animationController.reverse().whenComplete(() => () {});
                  setState(() {
                    isSelectedMode = false;
                  });
                }
              },
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(selection),
                child: AbsorbPointer(
                  absorbing: !isSelectedMode,
                  child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * 0.6,
                      color: Colors.white,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ...List.generate(
                              4,
                              (index) => Card3DItem(
                                    height: constraints.maxHeight * 0.5,
                                    card: cardList[index],
                                    percent: selection,
                                    depth: index,
                                    animation: animationControllerMovement,
                                    verticalFactor: getCurrentFactor(index),
                                    onCardSelected: (card) {
                                      _onCardSelected(card, index);
                                    },
                                  )).reversed,
                        ],
                      )),
                ),
              ),
            );
          });
    });
  }
}

class Card3DItem extends AnimatedWidget {
  const Card3DItem(
      {required this.height,
      required this.card,
      required this.percent,
      required this.depth,
      required this.onCardSelected,
      this.verticalFactor = 0,
      required this.animation,
      Key? key})
      : super(key: key, listenable: animation);
  final double height;
  final Card3D card;
  final double percent;
  final int depth;
  final int verticalFactor;
  final ValueChanged<Card3D> onCardSelected;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final bottomMargin = height / 4.0;
    print("Top: ${height + -depth * height / 2 * percent - bottomMargin}");
    return Positioned(
        left: 0,
        right: 0,
        top: height + -depth * height / 2 * percent - bottomMargin,
        child: Opacity(
          opacity: verticalFactor == 0 ? 1 : 1 - animation.value,
          child: Hero(
            tag: card.title,
            flightShuttleBuilder: (context, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              Widget _current;
              if (flightDirection == HeroFlightDirection.push) {
                _current = toHeroContext.widget;
              } else {
                _current = fromHeroContext.widget;
              }
              return AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    final newValue = lerpDouble(0.0, 2 * 3.14, animation.value);

                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(newValue!),
                      child: _current,
                    );
                  });
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate(
                    0.0,
                    verticalFactor *
                        animation.value *
                        MediaQuery.of(context).size.height,
                    depth * 50.0),
              child: GestureDetector(
                onTap: () {
                  onCardSelected(card);
                },
                child: SizedBox(
                  height: height,
                  child: Card3DWidget(card: card),
                ),
              ),
            ),
          ),
        ));
  }
}

class Card3DWidget extends StatefulWidget {
  const Card3DWidget({required this.card, Key? key}) : super(key: key);
  final Card3D card;
  @override
  _Card3DWidgetState createState() => _Card3DWidgetState();
}

class _Card3DWidgetState extends State<Card3DWidget> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          "assets/${widget.card.image}",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}

class CardsHorizontal extends StatelessWidget {
  const CardsHorizontal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Recently Played",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cardList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Card3D card = cardList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card3DWidget(
                        card: card,
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
