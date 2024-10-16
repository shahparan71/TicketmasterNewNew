import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as launcher;
import 'package:share_plus/share_plus.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/custom_dialog.dart';
import 'package:ticket_master/utils/widgets_util.dart';
import 'package:ticket_master/utils/custom_dialog.dart';

class GoogleMapFlutter extends StatefulWidget {
  @override
  State<GoogleMapFlutter> createState() => GoogleMapFlutterState();
}

class GoogleMapFlutterState extends State<GoogleMapFlutter> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? controller;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.8307148, -87.6353042),
    zoom: 16.0,
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
                            ),
                            FutureBuilder<String>(
                              future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.PLACE, "SofFi Stadium"),
                              builder: (context, AsyncSnapshot<String> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                } else {
                                  return GestureDetector(
                                    onTap: () async {
                                      String? result = await CustomInputDialog.showInputDialog(
                                        context: context,
                                        defaultTxt: "SofFi Stadium",
                                        key: AllConstant.CURRENT_LIST_INDEX + AllConstant.PLACE,
                                      );
                                      if (result != null) {
                                        PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.PLACE, result);
                                        setState(() {});
                                      } else {
                                        print("Dialog was canceled");
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      child: Container(
                                        child: Text(snapshot.data!,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: PrefUtil.preferences!
                                                        .getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond) ??
                                                    20,
                                                fontFamily: "metropolis",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black38)),
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
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
                            onLongPress: () async {
                              String? latLong = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG);
                              String? place = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.PLACE);

                              if (latLong == null || latLong.isEmpty) return;

                              final availableMaps = await launcher.MapLauncher.installedMaps;
                              print(
                                  availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                              await availableMaps.first.showMarker(
                                coords: launcher.Coords(double.parse(latLong.split(",")[0]),
                                    double.parse(latLong.split(",")[1])),
                                title: place??"SofFi Stadium",
                              );
                            },
                            onPressed: () async {
                              String? result = await CustomInputDialog.showInputDialog(
                                context: context,
                                defaultTxt: "23.42424,92.8787",
                                key: AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG,
                              );
                              if (result != null) {
                                PrefUtil.preferences!.setString(AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG, result);
                                setState(() {});
                                initData();
                              } else {
                                print("Dialog was canceled");
                              }
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
