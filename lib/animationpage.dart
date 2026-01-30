import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  late final AnimationController _controller;
  late final Animation<double> _yOffset;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuad,
    );

    _yOffset = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(_controller);

    _scale = Tween<double>(begin: 1.0, end: 3.0).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reset();
    }
    _controller.forward();
  }

  void _stop() => _controller.stop();

  void _reverse() => _controller.reverse();

  void _repeat() => _controller.repeat(reverse: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                builder: (context, child) {
                  //log("$_yOffset", name: "YOffset");
                  return Transform.translate(
                    offset: Offset(0.0, 0.0 ),
                    child: Transform.rotate(
                      angle: _yOffset.value ,
                      child: Transform.scale(
                        scale: _scale.value,
                        child: child,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Wrap(
            children: [
            Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _start, child: const Text('Start')),
                ElevatedButton(onPressed: _stop, child: const Text('Stop')),
                ElevatedButton(
                  onPressed: _reverse,
                  child: const Text('Reverse'),
                ),
                Container(
                  height: 40,
                  width: 40, 
              child: 
                ElevatedButton(
                  onPressed: _repeat,
                  child: const Text('Repeat'),)
                ),
              ],
            ),
          ),],
          )
        ],
      ),
    );
  }
}