import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_proj/State/vote.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {


  return runApp(MapsApp());

}

/// This widget will be the root of application.
class MapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Maps Demo',
      home: MyHomePage(),
    );
  }
}

/// This widget is the home page of the application.
class MyHomePage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  late List<Model> _data;
  late MapShapeSource _mapSource;
  @override
  void initState() {
    print("i voteed");
    print(Provider.of<VoteState>(context, listen: false).voted);

    _data = const <Model>[
      Model('Riviere du Rempart', Color.fromRGBO(255, 215, 0, 1.0),
          '       Riviere du\nRempart'),
      Model('Flacq', Color.fromRGBO(72, 209, 204, 1.0), 'Flacq'),
      Model('Grand Port', Color.fromRGBO(255, 78, 66, 1.0),
          'Grand\Port'),
      Model('Savanne', Color.fromRGBO(171, 56, 224, 0.75), 'Savanne'),
      Model('BlackRiver', Color.fromRGBO(126, 247, 74, 0.75),
          'BlackRiver'),
      Model('Port Louis', Color.fromRGBO(79, 60, 201, 0.7),
          'Port Louis'),
      Model('Pamplemousses', Color.fromRGBO(99, 164, 230, 1), 'Pamplemousses'),
      Model('Plaines Wilhems', Colors.teal, 'Plaines Wilhems'),
      Model('Moka', Colors.pink, 'Moka')
    ];

    _mapSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 520,
        child: Center(
          child: SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: _mapSource,
                showDataLabels: true,
                legend: const MapLegend(MapElement.shape),
                tooltipSettings: MapTooltipSettings(
                    color: Colors.grey[700],
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Colors.white,
                strokeWidth: 1,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _data[index].stateCode,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                dataLabelSettings: MapDataLabelSettings(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:
                        Theme.of(context).textTheme.caption!.fontSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Collection of Australia state code data.
class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}