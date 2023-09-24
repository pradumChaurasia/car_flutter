import 'package:flutter/material.dart';

class LinearLoading extends StatefulWidget {
  const LinearLoading({super.key});

  @override
  State<LinearLoading> createState() => _LinearLoadingState();
}

class _LinearLoadingState extends State<LinearLoading> with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller=AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      // upperBound: 100,
    );

    controller.addListener(() {
      setState(() {

      });
    });
    controller.forward();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:12.0),
      alignment: Alignment.center,
      child: LinearProgressIndicator(
        color:Colors.amberAccent,
        value: controller.value,
      )
    );
  }
}




class CircularLoading extends StatefulWidget {
  const CircularLoading({super.key});

  @override
  State<CircularLoading> createState() => _CircularLoadingState();
}

class _CircularLoadingState extends State<CircularLoading> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller=AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),

    );
    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top:12.0),
        child: CircularProgressIndicator(
          value:controller.value,
          color: Colors.amberAccent,

        )
    );;
  }
}



