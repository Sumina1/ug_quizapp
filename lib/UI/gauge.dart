import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge extends StatefulWidget {
  @override
  final double value;
  final String annotation;
  final Color pointerColor;
  const Gauge({Key key, this.value, this.annotation, this.pointerColor}) : super(key: key);
  _GaugeState createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfRadialGauge(
          enableLoadingAnimation: true,
          axes:<RadialAxis>[RadialAxis(ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: widget.value,
                color: widget.pointerColor,
                startWidth: 10,
                endWidth: 10),],
              showLabels: false,
              showTicks: false,
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  angle: 90,
                  axisValue: 5,
                  positionFactor: 0.1,
                  widget: Text('${widget.annotation}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ),
                GaugeAnnotation(
                    angle: 90,
                    axisValue: 5,
                    positionFactor: 0.3,

                    widget: Text('${widget.value}',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold) )
                ),


              ] ),]
      ),
    );
  }
}