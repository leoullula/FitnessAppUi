import 'package:fitness_app/fitness_data.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'graph.dart';
class ShowGraph extends StatefulWidget {
  @override
  _ShowGraphState createState() => _ShowGraphState();
}

class _ShowGraphState extends State<ShowGraph> with SingleTickerProviderStateMixin<ShowGraph> {
  AnimationController _graph;
  @override
  void initState() {
   _graph = AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }
  @override
  void dispose() {
    _graph.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap:(){_graph.forward();} ,
              child: InkWell(
                onTap: (){
                  _graph.forward();
    },
               child: Graph(
               animationController:  _graph,
                 values: dayData
              ),
            )
          ),
        ),
         )
    );
  }
}
