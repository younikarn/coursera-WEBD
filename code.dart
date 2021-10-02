import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/drawer.dart';
import 'package:flash_chat/screens/order/components/bouncing_button.dart';
import 'package:flash_chat/screens/order/components/mainscreenbutton.dart';
import 'package:flash_chat/screens/order/create_order.dart';
import 'package:flash_chat/screens/registering_user/loading_screen.dart';
import 'package:flash_chat/screens/registering_user/welcome_screen.dart';
import 'package:flash_chat/screens/view_order/delete_order_list.dart';
import 'package:flash_chat/screens/view_order/view_order_list.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_icons/animate_icons.dart';

class MainScreen extends StatefulWidget {
  final String phone;
  MainScreen({this.phone});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  GlobalKey _fabKey = GlobalObjectKey("fab");
  final _auth = FirebaseAuth.instance;

  User user;
  bool isExpanded = true;
  Duration duration = Duration(milliseconds: 300);
  double screenheight, screenwidth;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double _scale;
  AnimationController _controller, controller2;
  Animation<double> _scaleAnimation;
  Animation<Offset> _slideAnimation;
  Animation<double> _slidescaleAnimation;
  AnimateIconController iconController;

  bool buttonpressed = true;

  String name;
  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      print('user not null');

      // user.updateProfile(displayName: null);
      name = user.displayName;
      print(name);
    } else {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => WelcomeScreen()),
      //     (route) => false);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      });
    }
    controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-0.4, 0), end: Offset(0, 0))
        .animate(_controller);
    _slidescaleAnimation =
        Tween<double>(begin: 0.6, end: 1).animate(_controller);

    iconController = AnimateIconController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - controller2.value;
    screenheight = MediaQuery.of(context).size.height;
    screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            MainDrawer(
              slideanimation: _slideAnimation,
              slidescaleanimation: _slidescaleAnimation,
            ),
            AnimatedPositioned(
              duration: duration,
              top: 0,
              bottom: 0,
              left: isExpanded ? 0 : 0.5 * screenwidth,
              right: isExpanded ? 0 : -0.5 * screenwidth,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    int sensitvity = 5;
                    if (isExpanded) {
                      if (details.delta.dx > sensitvity) {
                        setState(() {
                          if (!iconController.isEnd()) {
                            iconController.animateToEnd();
                          }
                          if (isExpanded)
                            _controller.forward();
                          else
                            _controller.reverse();
                          isExpanded = !isExpanded;
                        });
                      }
                    } else if (details.delta.dx < -sensitvity) {
                      setState(() {
                        if (!iconController.isStart()) {
                          iconController.animateToStart();
                        }
                        if (isExpanded)
                          _controller.forward();
                        else
                          _controller.reverse();
                        isExpanded = !isExpanded;
                      });
                    }
                  },
                  onTap: isExpanded
                      ? () {}
                      : () {
                          setState(() {
                            if (!iconController.isStart()) {
                              iconController.animateToStart();
                            }
                            if (isExpanded)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isExpanded = !isExpanded;
                          });
                        },
                  child: Material(
                    animationDuration: Duration(milliseconds: 650),
                    elevation: isExpanded ? 0 : 8,
                    borderRadius: isExpanded
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(25),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Row(
                            textBaseline: TextBaseline.ideographic,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent),
                                child: GestureDetector(
                                  // onTapDown: (TapDownDetails tapdowndetails) {
                                  //   print('button pressed');
                                  //   setState(() {
                                  //     buttonpressed = false;
                                  //   });
                                  // },
                                  // onTapCancel: () {
                                  //   setState(() {
                                  //     buttonpressed = true;
                                  //   });
                                  //   print('tap not successful');
                                  // },
                                  // onTapUp: (TapUpDetails tapupdetails) {
                                  //   print('button tapped up');
                                  // },
                                  // onTap: () async {

                                  //   setState(() {
                                  //     buttonpressed = true;
                                  //     if (isExpanded)
                                  //       _controller.forward();
                                  //     else
                                  //       _controller.reverse();
                                  //     isExpanded = !isExpanded;
                                  //   });
                                  // },
                                  child: Container(
                                    key: _fabKey,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[300],
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(15)),
                                    ),
                                    padding: EdgeInsets.all(1),
                                    child: BounceButton(
                                      child: AnimateIcons(
                                        startIcon: Icons.menu_open,
                                        endIcon: Icons.close,
                                        startIconColor: buttonpressed
                                            ? Colors.blue
                                            : Colors.white,
                                        onStartIconPress: () {
                                          // setState(() {
                                          //   if (!iconController.isStart()) {
                                          //     iconController.animateToStart();
                                          //   }
                                          //   if (isExpanded)
                                          //     _controller.forward();
                                          //   else
                                          //     _controller.reverse();
                                          //   isExpanded = !isExpanded;
                                          // });
                                          showFAB();
                                          return true;
                                        },
                                        onEndIconPress: () {
                                          setState(() {
                                            if (!iconController.isStart()) {
                                              iconController.animateToStart();
                                            }
                                            if (isExpanded)
                                              _controller.forward();
                                            else
                                              _controller.reverse();
                                            isExpanded = !isExpanded;
                                          });

                                          return true;
                                        },
                                        controller: iconController,
                                        duration: Duration(milliseconds: 500),
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Hello",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Flexible(
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        ColorizeAnimatedText(
                                          '$name',
                                          speed: Duration(milliseconds: 5000),
                                          textAlign: TextAlign.center,
                                          textStyle: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'Horizon'),
                                          colors: [
                                            Colors.purple,
                                            Colors.blue,
                                            Colors.yellow,
                                            Colors.red,
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Center(
                        //     child: AnimatedTextKit(
                        //       repeatForever: true,
                        //       animatedTexts: [
                        //         ColorizeAnimatedText(
                        //           'Welcome \n $name',
                        //           speed: Duration(milliseconds: 500),
                        //           textAlign: TextAlign.center,
                        //           textStyle: TextStyle(
                        //               fontSize: 50.0, fontFamily: 'Horizon'),
                        //           colors: [
                        //             Colors.purple,
                        //             Colors.blue,
                        //             Colors.yellow,
                        //             Colors.red,
                        //           ],
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainScreenButton(
                                startColor: Color(0xFFD38C96),
                                endColor: Color(0xFF008097),
                                buttonIcon: Icons.list_alt_outlined,
                                buttonText: 'Create Order',
                                onTap: isExpanded
                                    ? () async {
                                        await Future.delayed(
                                            Duration(milliseconds: 50));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateOrder()));
                                      }
                                    : () {
                                        setState(() {
                                          if (!iconController.isStart()) {
                                            iconController.animateToStart();
                                          }
                                          if (isExpanded)
                                            _controller.forward();
                                          else
                                            _controller.reverse();
                                          isExpanded = !isExpanded;
                                        });
                                      },
                              ),
                              MainScreenButton(
                                buttonText: 'View Order',
                                buttonIcon: Icons.list_alt_outlined,
                                startColor: Color(0xFFC3A896),
                                endColor: Colors.green[400],
                                onTap: isExpanded
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OrderList(
                                                      uid: user.uid,
                                                      name: user.displayName,
                                                    )));
                                      }
                                    : () {
                                        setState(() {
                                          if (!iconController.isStart()) {
                                            iconController.animateToStart();
                                          }
                                          if (isExpanded)
                                            _controller.forward();
                                          else
                                            _controller.reverse();
                                          isExpanded = !isExpanded;
                                        });
                                      },
                              ),
                              MainScreenButton(
                                buttonText: 'Delete Order',
                                buttonIcon: Icons.delete_forever_outlined,
                                startColor: Colors.cyanAccent[100],
                                endColor: Colors.cyanAccent[700],
                                onTap: isExpanded
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeleteOrderList(
                                                      uid: user.uid,
                                                      name: user.displayName,
                                                    )));
                                      }
                                    : () {
                                        setState(() {
                                          if (!iconController.isStart()) {
                                            iconController.animateToStart();
                                          }
                                          if (isExpanded)
                                            _controller.forward();
                                          else
                                            _controller.reverse();
                                          isExpanded = !isExpanded;
                                        });
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFAB() {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _fabKey.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(
      center: markRect.center,
      radius: markRect.longestSide * 0.6,
    );

    coachMarkFAB.show(
      targetContext: _fabKey.currentContext,
      markRect: markRect,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "This is called\nFloatingActionButton",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
      duration:
          null, // we don't want to dismiss this mark automatically so we are passing null
      // when this mark is closed, after 1s we show mark on RaisedButton
      onClose: () => print('coachmark closed'),
    );
  }
}
