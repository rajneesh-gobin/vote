import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_proj/Screens/home_screen.dart';
import 'package:my_proj/Screens/launch_screen.dart';
import 'package:my_proj/State/vote.dart';
import 'package:my_proj/models/vote.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// void main() {
//   return runApp(MapsApp());
// }

// /// This widget will be the root of application.
// class MapsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: MyHomePage(),
//     );
//   }
// }

/// This widget is the home page of the application.
class MapPage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  _MapPageState();

  late List<Model> _data;
  late MapShapeSource _mapSource;
  @override
  void initState() {
    print(Provider.of<VoteState>(context, listen: false).voted);

    String blackriver = "Registered: "+Provider.of<VoteState>(context, listen: false)
            .BlackRiverNoVoted
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false)
            .BlackRiverVoted
            .toString();

    String BlackRiverTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .BlackRiverTotal
        .toString();

    String Flacq = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .FlacqNoVoted+Provider.of<VoteState>(context, listen: false).FlacqVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false).FlacqVoted.toString();

    String FlacqTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .FlacqTotal
        .toString();

    String GrandPort = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .GrandPortNoVoted+Provider.of<VoteState>(context, listen: false)
        .GrandPortVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false)
            .GrandPortVoted
            .toString();
    String GrandPortTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .GrandPortTotal
        .toString();
    String Moka ="Registered: "+(
        Provider.of<VoteState>(context, listen: false).MokaNoVoted+Provider.of<VoteState>(context, listen: false).MokaVoted).toString() +
            "\nVoted:" +
            Provider.of<VoteState>(context, listen: false).MokaVoted.toString();
    String MokaTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .MokaTotal
        .toString();
    String Pamplemousses = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .PamplemoussesNoVoted+Provider.of<VoteState>(context, listen: false)
        .PamplemoussesVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false)
            .PamplemoussesVoted
            .toString();
    String PamplemoussesTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .PamplemoussesTotal
        .toString();
    String PlainesWilhems = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .PlainesWilhemsNoVoted+ Provider.of<VoteState>(context, listen: false)
        .PlainesWilhemsVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false)
            .PlainesWilhemsVoted
            .toString();
    String PlainesWilhemsTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .PlainesWilhemsTotal
        .toString();
    String PortLouis = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .PortLouisNoVoted+Provider.of<VoteState>(context, listen: false)
        .PortLouisVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false)
            .PortLouisVoted
            .toString();
    String PortLouisTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .PortLouisTotal
        .toString();
    String RiviereduRempart = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .RiviereduRempartNoVoted+  Provider.of<VoteState>(context, listen: false)
        .RiviereduRempartVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false)
            .RiviereduRempartVoted
            .toString();
    String RiviereduRempartTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .RiviereduRempartTotal
        .toString();
    String Savanne = "Registered: "+(Provider.of<VoteState>(context, listen: false)
            .SavanneNoVoted+Provider.of<VoteState>(context, listen: false).SavanneVoted)
            .toString() +
        "\nVoted: " +
        Provider.of<VoteState>(context, listen: false).SavanneVoted.toString();
    String SavanneTotal="Total: "+Provider.of<VoteState>(context, listen: false)
        .SavanneTotal
        .toString();


    _data = <Model>[
      Model('RiviereduRempart', Color.fromRGBO(255, 215, 0, 1.0),
          RiviereduRempart,RiviereduRempartTotal),
      Model('Flacq', Color.fromRGBO(72, 209, 204, 1.0), Flacq,FlacqTotal),
      Model('GrandPort', Color.fromRGBO(255, 78, 66, 1.0), GrandPort, GrandPortTotal),
      Model('Savanne', Color.fromRGBO(171, 56, 224, 0.75), Savanne,SavanneTotal),
      Model('BlackRiver', Color.fromRGBO(126, 247, 74, 0.75), blackriver, BlackRiverTotal),
      Model('PortLouis', Color.fromRGBO(79, 60, 201, 0.7), PortLouis, PortLouisTotal),
      Model('Pamplemousses', Color.fromRGBO(99, 164, 230, 1), Pamplemousses, PamplemoussesTotal),
      Model('PlainesWilhems', Colors.teal, PlainesWilhems, PlainesWilhemsTotal),
      Model('Moka', Colors.pink, Moka, MokaTotal)
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
      body: Column(
        children: [
          Container(
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
                          _data[index].totalVoters,
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
          SizedBox(height: 12.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LaunchScreen(),
              //   ),
              // );

              Navigator.pop(context);
            },
            child: Text("Go Back"),
          ),
        ],
      ),
    );
  }
}

/// Collection of Australia state code data.
class Model {
  const Model(this.state, this.color, this.stateCode,this.totalVoters);

  final String state;

  final Color color;

  final String stateCode;

  final String totalVoters;
}
