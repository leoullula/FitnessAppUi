import 'package:fitness_app/blocs/home_page_bloc.dart';
import 'package:fitness_app/date_utils.dart';
import 'package:fitness_app/radial_progress.dart';
import 'package:fitness_app/show_graph.dart';
import 'package:fitness_app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'curve.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: appTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  HomePageBlo _homePageBloc;
  AnimationController _iconAC;


  @override
  void initState() {
    _homePageBloc = HomePageBlo();
    _iconAC = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    super.initState();
  }
  @override
  void dispose() {
   _homePageBloc.dispose();
   _iconAC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(children: <Widget>[
                TopBar(),
                Positioned(
                  top: 55.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 30.0),
                          onPressed: () {
                            _homePageBloc.subtractDate();

                          }),
                      StreamBuilder(
                        stream: _homePageBloc.dateStream,
                        initialData: _homePageBloc.selectedDate,
                        builder: (context,snapshot)
                        {
                          return Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  formatterDayOfWeek.format(snapshot.data),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      letterSpacing: 1.5,
                                      color: Colors.white),
                                ),
                                Text(fD.format(snapshot.data),
                                    style: TextStyle(
                                        letterSpacing: 2.0,
                                        fontSize: 20.0,
                                        color: Colors.white
                                    )
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Transform.rotate(
                        angle: 135,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: Colors.white, size: 30.0),
                            onPressed: () {
                              _homePageBloc.addDate();
                            }),
                      )
                    ],
                  ),
                )
              ]
              ),
              RadialProgress(),
                 MonthlyStatusListing()
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red,width: 4.0)
              ),
              child: IconButton(icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: Colors.red,
                  progress: _iconAC.view), onPressed: () {
                onIconPressed();
              }),
            ),
          )
        ],

      ),
    );
  }
  void onIconPressed() {
    animationStatus
        ? _iconAC.reverse()
        : _iconAC.forward();
  }

  bool get animationStatus {
    final AnimationStatus status = _iconAC.status;
    return status == AnimationStatus.completed;
  }
}
class MonthlyStatusListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(

      child:
      Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
       mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              MonthlyStatusRow('February 2017', 'On going'),
              MonthlyStatusRow('January 2017', 'Failed'),
              MonthlyStatusRow('December 2016', 'Completed'),
            ],
          ),
          Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              MonthlyTargetRow('Lose weight', '3.8 ktgt/7 kg'),
              MonthlyTargetRow('Running per month', '15.3 km/20 km'),
              MonthlyTargetRow('Avg steps Per day', '10000/10000'),
            ],
          ),
        ],
      ),
    );
  }
}



class MonthlyStatusRow extends StatelessWidget {
  final String monthYear, status;

  MonthlyStatusRow(this.monthYear, this.status);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            monthYear,
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          Text(
            status,
            style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}

class MonthlyTargetRow extends StatelessWidget {
  final String target, targetAchieved;

  MonthlyTargetRow(this.target, this.targetAchieved);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            target,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
          Text(
            targetAchieved,
            style: TextStyle(color: Colors.grey, fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}




