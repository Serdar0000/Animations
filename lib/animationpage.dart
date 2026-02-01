import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExplicitAnimationsPage(),
    );
  }
}

class ExplicitAnimationsPage extends StatefulWidget {
  const ExplicitAnimationsPage({super.key});

  @override
  State<ExplicitAnimationsPage> createState() => _ExplicitAnimationsPageState();
}

class _ExplicitAnimationsPageState extends State<ExplicitAnimationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _heightAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _widthAnimation = Tween<double>(begin: 100.0, end: 250.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _heightAnimation = Tween<double>(begin: 100.0, end: 150.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(10),
      end: BorderRadius.circular(75),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animation Full Control")),
      body: Center( 
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: _widthAnimation.value,
              height: _heightAnimation.value,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: _borderRadiusAnimation.value,
              ),
              alignment: Alignment.center,
              child: const Text(
                "BOX",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        spacing: 10,
        children: [
          FloatingActionButton.extended(
            heroTag: "forward",
            onPressed: () => _controller.forward(),
            label: const Text("Forward"),
            icon: const Icon(Icons.arrow_forward),
          ),
          FloatingActionButton.extended(
            heroTag: "reverse",
            onPressed: () => _controller.reverse(),
            label: const Text("Reverse"),
            icon: const Icon(Icons.arrow_back),
          ),
          FloatingActionButton.extended(
            heroTag: "repeat",
            onPressed: () => _controller.repeat(reverse: true),
            label: const Text("Repeat"),
            icon: const Icon(Icons.replay),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            heroTag: "stop",
            onPressed: () => _controller.stop(),
            label: const Text("Stop"),
            icon: const Icon(Icons.stop),
          ),
        ],
      ),
    );
  }
}