import 'package:flutter/material.dart';

class ScaleAnim extends StatefulWidget {
  const ScaleAnim({Key? key}) : super(key: key);

  @override
  _ScaleAnimState createState() => _ScaleAnimState();
}

class _ScaleAnimState extends State<ScaleAnim> {
  double _value = 0.2;

  @override
  void initState() {
    super.initState();
    inc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(3.14 * _value),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/image.png",
                height: 100,
              ),
            ),
            Slider(
                min: 0.2,
                max: 1,
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                }),
            SizedBox(
              height: 100,
            ),
            Text("value : ${_value.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }

  void inc() {
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {
        _value += 0.1;
        if (_value <= 0.9) {
          inc();
        }
      });
    });
  }
}
