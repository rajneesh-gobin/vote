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


    print(Provider.of<VoteState>(context, listen: false).voted);



    String blackriver = Provider.of<VoteState>(context, listen: false).BlackRiverNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).BlackRiverVoted.toString();
    String Flacq = Provider.of<VoteState>(context, listen: false).FlacqNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).FlacqVoted.toString();
    String GrandPort = Provider.of<VoteState>(context, listen: false).GrandPortNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).GrandPortVoted.toString();
    String Moka = Provider.of<VoteState>(context, listen: false).MokaNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).MokaVoted.toString();
    String Pamplemousses = Provider.of<VoteState>(context, listen: false).PamplemoussesNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).PamplemoussesVoted.toString();
    String PlainesWilhems = Provider.of<VoteState>(context, listen: false).PlainesWilhemsNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).PlainesWilhemsVoted.toString();
    String PortLouis = Provider.of<VoteState>(context, listen: false).PortLouisNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).PortLouisVoted.toString();
    String RiviereduRempart = Provider.of<VoteState>(context, listen: false).RiviereduRempartNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).RiviereduRempartVoted.toString();
    String Savanne = Provider.of<VoteState>(context, listen: false).SavanneNoVoted.toString()+"/"+Provider.of<VoteState>(context, listen: false).SavanneVoted.toString();

    _data =  <Model>[
      Model('RiviereduRempart', Color.fromRGBO(255, 215, 0, 1.0),
    RiviereduRempart),
      Model('Flacq', Color.fromRGBO(72, 209, 204, 1.0), Flacq),
      Model('GrandPort', Color.fromRGBO(255, 78, 66, 1.0),
    GrandPort),
      Model('Savanne', Color.fromRGBO(171, 56, 224, 0.75), Savanne),
      Model('BlackRiver', Color.fromRGBO(126, 247, 74, 0.75),
          blackriver),
      Model('PortLouis', Color.fromRGBO(79, 60, 201, 0.7),
    PortLouis),
      Model('Pamplemousses', Color.fromRGBO(99, 164, 230, 1), Pamplemousses),
      Model('PlainesWilhems', Colors.teal, PlainesWilhems),
      Model('Moka', Colors.pink, Moka)
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