import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:share_plus/share_plus.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class GoogleMapFlutter extends StatefulWidget {
  @override
  State<GoogleMapFlutter> createState() => GoogleMapFlutterState();
}

class GoogleMapFlutterState extends State<GoogleMapFlutter> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? controller;
  var textEditingController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.8307148, -87.6353042),
    zoom: 18.0,
  );

  Map<MarkerId, Marker> allTypeMarker = <MarkerId, Marker>{};

/*
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799, target: LatLng(37.43296265331129, -122.08832357078792), tilt: 59.440717697143555, zoom: 19.151926040649414);
*/

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            height: 350,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0XFFffffff),
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        height: 250,
                        child: Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: false,
                              zoomControlsEnabled: true,
                              markers: Set<Marker>.of(allTypeMarker.values),
                              onMapCreated: (GoogleMapController controllerInner) async {
                                _controller.complete(controllerInner);
                                controller = await _controller.future;
                              },
                              onTap: (v) async {
                                double zoom = await controller!.getZoomLevel();
                                print(zoom);
                              },
                            ),
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.white.withOpacity(0.1),
                            )
                            /*Positioned(
                            bottom: 100,
                            right: 10,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0, 0), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  height: 40,
                                  width: 40,
                                  child: GestureDetector(
                                      onTap: () async {
                                        final GoogleMapController controller = await _controller.future;
                                        controller.animateCamera(CameraUpdate.zoomIn());
                                      },
                                      child: Icon(Icons.add)),
                                ),
                                SizedBox(height: 2),
                                GestureDetector(
                                  onTap: () async {
                                    final GoogleMapController controller = await _controller.future;
                                    controller.animateCamera(CameraUpdate.zoomOut());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 0), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                              ],
                            ),
                          )*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            child: Text("Get Directions",
                                style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
                            /*style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.colorMain(),
                                    ),*/
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              elevation: 0.0,
                              backgroundColor: AppColor.colorMain(),
                              // Background color
                              foregroundColor: Colors.white,
                              // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                              ),
                            ),
                            onPressed: () async {
                              putLatLong(AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG, "23.42424,92.8787");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),

      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    //await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> initData() async {
    allTypeMarker.clear();
    setState(() {});

    String? valueT = await PrefUtil.preferences!.getString("${AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG}");
    if (valueT == null)
      return;
    else {
      double lat = double.parse(valueT.split(",")[0]);
      double long = double.parse(valueT.split(",")[1]);

      //GeoPoint geoPoint = GeoPoint(latitude: lat, longitude: long);

      await CommonOperation.getBytesFromAsset('assets/images/map_icon_marker.png', 200).then((onValue) async {
        final String markerIdVal = '1212';
        final MarkerId markerId = MarkerId(markerIdVal);
        Marker marker = Marker(
          markerId: markerId,
          position: LatLng(lat, long),
          icon: BitmapDescriptor.fromBytes(onValue),
        );
        allTypeMarker[markerId] = marker;
        await controller?.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              bearing: 0.0,
              target: LatLng(lat, long),
              tilt: 30.0,
              zoom: 16.0,
            ),
          ),
        );
        setState(() {});
      });
    }
  }

  void putLatLong(String sec, String defaultTxt) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetsUtil.inputBoxForAll(defaultTxt, sec, textEditingController, inputType: TextInputType.number),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text("OK", style: TextStyle(fontSize: 18, fontFamily: "metropolis", fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green(),
                    ),
                    onPressed: () {
                      if (textEditingController.text.toString().isNotEmpty) {
                        PrefUtil.preferences!.setString(sec, textEditingController.text);
                        textEditingController.text = "";
                        setState(() {});
                      }

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              //myPledge: model,
            ),
          );
        }).then((v) {
      initData();
    });
  }

  Future<void> gotoPosition() async {
    String? valueT = await PrefUtil.preferences!.getString("${AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG}");
    if (valueT == null)
      return;
    else {
      double lat = double.parse(valueT.split(",")[0]);
      double long = double.parse(valueT.split(",")[1]);

      //GeoPoint geoPoint = GeoPoint(latitude: lat, longitude: long);
    }
  }
}
