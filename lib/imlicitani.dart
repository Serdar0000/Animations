import 'package:flutter/material.dart';

class Animations extends StatefulWidget {
  const Animations({super.key});

  @override
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> {
  bool controller = false;
  double opacity1 = 1.0;
  bool controller2 = false;
  bool isPressed = false;
  int _count = 0;


  void changeOpacity() {
    setState(() {
      opacity1 = opacity1 == 0 ? 0.0: 1.0 ; 
    });
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          AnimatedOpacity(
            
            opacity: opacity1,
            duration: Duration(seconds: 1),
            child: Text("Opacity check")
            ),
            ElevatedButton(onPressed: changeOpacity,
             child: Text("Opacity ex")
             ),
          GestureDetector(
      onTap: (){
        setState(() {
          controller = !controller;
        });
      },
      child: Center(
        child: AnimatedContainer(
          height: controller ? 100: 20,
          width: controller ? 100 : 20,
          color: controller ? Colors.amber: Colors.blueAccent,
          duration: Duration(seconds: 3),
          curve: Curves.linear,
          child: Icon(Icons.hourglass_empty_sharp),
          ),
      ),
    ),
    // GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       controller2 = !controller2;
    //     });
    //   },
    //   child: Container(
    //     width: 200,
    //     height: 200,color: 
    //     Colors.blueAccent,
    //     child: AnimatedAlign(alignment: controller2 ? AlignmentGeometry.topCenter : AlignmentGeometry.xy(0, 0), 
    //     duration: Duration(seconds: 2),
    //     curve: Curves.bounceInOut,
    //     child: FlutterLogo(),
    //     ),
    //   ),
    // ),
    GestureDetector(
      onTap: () {
        setState(() {
        isPressed = ! isPressed;
        });
      },
      child: Container(
        color: Colors.white,
        width: 250,
        height: 250,
        child: AnimatedScale(
          scale: isPressed ? 0.90 : 1.0,
     duration: Duration(seconds: 10),
     child: Container(
      width: 100,
      height: 100,
      color: Colors.amber,
     ),
     ),
      ),
      ),
      AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              '$_count',
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ElevatedButton(
            child: const Text('Increment'),
            onPressed: () {
              setState(() {
                _count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}