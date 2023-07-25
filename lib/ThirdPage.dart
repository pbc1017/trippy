import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

enum ButtonType {
  coffee,
  store,
  carpark,
}

class ThirdPage extends StatefulWidget{
  const ThirdPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>{
  late KakaoMapController mapController;

  Set<Marker> markers = {};
  ButtonType buttonType = ButtonType.coffee;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Stack(
        children: [
          KakaoMap(
            onMapCreated: ((controller) async {
              mapController = controller;

              setState(() {});
            }),
            markers: markers.toList(),
            center: LatLng(37.498004414546934, 127.02770621963765),
          ),
          Row(
            children: [
              MaterialButton(
                onPressed: () {
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.499590490909185, 127.0263723554437),width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.499427948430814, 127.02794423197847), width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.498553760499505, 127.02882598822454), width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.497625593121384, 127.02935713582038), width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49646391248451, 127.02675574250912), width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49629291770947, 127.02587362608637), width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49754540521486, 127.02546694890695), width: 50, height: 50, offsetX:25, offsetY:50,markerImageSrc: 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'));

                  buttonType = ButtonType.coffee;
                  setState(() {});

                  mapController.setCenter(LatLng(37.499590490909185, 127.0263723554437));
                },
                color: buttonType == ButtonType.coffee ? Colors.blue : Colors.grey,
                child: const Text('커피숍'),
              ),
              MaterialButton(
                onPressed: () {
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.497535461505684, 127.02948149502778)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49671536281186, 127.03020491448352)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.496201943633714, 127.02959405469642)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49640072567703, 127.02726459882308)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49640098874988, 127.02609983175294)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49932849491523, 127.02935780247945)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49996818951873, 127.02943721562295)));

                  buttonType = ButtonType.store;
                  setState(() {});

                  mapController.setCenter(LatLng(37.497535461505684, 127.02948149502778));
                },
                color: buttonType == ButtonType.store? Colors.blue : Colors.grey,
                child: const Text('편의점'),
              ),
              MaterialButton(
                onPressed: () {
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49966168796031, 127.03007039430118)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.499463762912974, 127.0288828824399)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49896834100913, 127.02833986892401)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49893267508434, 127.02673400572665)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49872543597439, 127.02676785815386)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.49813096097184, 127.02591949495914)));
                  markers.add(Marker(markerId: markers.length.toString(), latLng: LatLng(37.497680616783086, 127.02518427952202)));

                  buttonType = ButtonType.carpark;
                  setState(() {});

                  mapController.setCenter(LatLng(37.497680616783086, 127.02518427952202));
                },
                color: buttonType == ButtonType.carpark? Colors.blue : Colors.grey,
                child: const Text('주차장'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
