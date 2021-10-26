import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'package:shimmer/shimmer.dart';

class SliderButton extends StatefulWidget {
  ///To make button more customizable add your child widget
  final Widget child;

  ///Sets the radius of corners of a button.
  final double radius;

  ///Use it to define a height and width of widget.
  final double height;
  final double width;
  final double buttonSize;

  ///Use it to define a color of widget.
  final Color backgroundColor;
  final Color baseColor;
  final Color highlightedColor;
  final Color buttonColor;

  ///Change it to gave a label on a widget of your choice.
  final Text label;

  ///Gives a alignment to a slider icon.
  final Alignment alignLabel;
  final BoxShadow boxShadow;
  final Widget icon;
  final Function action;

  ///Make it false if you want to deactivate the shimmer effect.
  final bool shimmer;

  ///Make it false if you want maintain the widget in the tree.
  final bool dismissible;

  final bool vibrationFlag;

  ///The offset threshold the item has to be dragged in order to be considered
  ///dismissed e.g. if it is 0.4, then the item has to be dragged
  /// at least 40% towards one direction to be considered dismissed
  final double dismissThresholds;

  final bool disable;
  SliderButton({
    @required this.action,
    this.radius,
    this.boxShadow,
    this.child,
    this.vibrationFlag,
    this.shimmer,
    this.height,
    this.buttonSize,
    this.width,
    this.alignLabel = const Alignment(0.4, 0),
    this.backgroundColor = const Color(0xffe0e0e0),
    this.baseColor = Colors.black87,
    this.buttonColor = Colors.white,
    this.highlightedColor = Colors.white,
    this.label,
    this.icon,
    this.dismissible = true,
    this.dismissThresholds = 1.0,
    this.disable = false,
  }) : assert((buttonSize ?? 60) <= (height ?? 70));

  @override
  _SliderButtonState createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  bool flag;
  bool isvisible = true;

  @override
  void initState() {
    super.initState();
    flag = true;
  }

  @override
  Widget build(BuildContext context) {
    return flag == true
        ? _control()
        : widget.dismissible == true
            ? Container()
            : Container(
                child: _control(),
              );
  }

  Widget _control() => AnimatedOpacity(
        opacity: isvisible ? 1 : 0,
        duration: Duration(milliseconds: 500),
        child: Container(
          height: 70,
          width: widget.width ?? 250,
          decoration: BoxDecoration(
              color: widget.disable
                  ? Colors.grey.shade700
                  : widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.radius ?? 100)),
          alignment: Alignment.centerLeft,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                alignment: widget.alignLabel,
                child: widget.shimmer ?? true && !widget.disable
                    ? Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 70 * 0.85),
                          child: Shimmer.fromColors(
                            baseColor:
                                widget.disable ? Colors.grey : widget.baseColor,
                            highlightColor: Colors.orangeAccent[100],
                            child: widget.label,
                            period: Duration(seconds: 2),
                          ),
                        ),
                      )
                    : widget.label,
              ),
              widget.disable
                  ? Tooltip(
                      verticalOffset: 150,
                      preferBelow: true,
                      message: 'Button is disabled',
                      child: Container(
                        width: (widget.width ?? 250) - (widget.height ?? 70),
                        height: (widget.height ?? 70),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: widget.height == null
                              ? (70 -
                                      (widget.buttonSize == null
                                          ? 60
                                          : widget.buttonSize)) /
                                  2
                              : (widget.height -
                                      (widget.buttonSize == null
                                          ? widget.height * 0.9
                                          : widget.buttonSize)) /
                                  2,
                        ),
                        child: widget.child ??
                            Container(
                              height: widget.buttonSize ??
                                  widget.height ??
                                  70 * 0.9,
                              width: widget.buttonSize ??
                                  widget.height ??
                                  70 * 0.9,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    widget.boxShadow,
                                  ],
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                      widget.radius ?? 100)),
                              child: Center(child: widget.icon),
                            ),
                      ),
                    )
                  : Dismissible(
                      resizeDuration: Duration(milliseconds: 50),
                      background: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(100)),
                            color: widget.backgroundColor),
                      ),
                      key: Key("cancel"),
                      direction: DismissDirection.startToEnd,
                      dismissThresholds: {DismissDirection.startToEnd: 0.9},
                      onResize: () {
                        setState(() {
                          isvisible = false;
                        });
                      },

                      ///gives direction of swipping in argument.
                      onDismissed: (dir) async {
                        widget.action();

                        // if (widget.vibrationFlag ??
                        //     true && await Vibration.hasVibrator()) {
                        //   try {
                        //     Vibration.vibrate(duration: 200);
                        //   } catch (e) {
                        //     print(e);
                        //   }
                        // }
                      },
                      child: Container(
                        width: (widget.width ?? 250) - (widget.height ?? 70),
                        height: widget.height ?? 70,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: widget.height == null
                              ? (70 -
                                      (widget.buttonSize == null
                                          ? 60
                                          : widget.buttonSize)) /
                                  2
                              : (widget.height -
                                      (widget.buttonSize == null
                                          ? widget.height * 0.9
                                          : widget.buttonSize)) /
                                  2,
                        ),
                        child: widget.child ??
                            Container(
                              height: widget.buttonSize ??
                                  widget.height ??
                                  70 * 0.9,
                              width: widget.buttonSize ??
                                  widget.height ??
                                  70 * 0.9,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    widget.boxShadow,
                                  ],
                                  color: widget.buttonColor,
                                  borderRadius: BorderRadius.circular(
                                      widget.radius ?? 100)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: widget.icon),
                                ],
                              ),
                            ),
                      ),
                    ),
              Container(
                child: SizedBox.expand(),
              ),
            ],
          ),
        ),
      );
}
