import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ticket_master/PrefUtil.dart';
import 'package:ticket_master/utils/AppColor.dart';
import 'package:ticket_master/utils/CommonOperation.dart';
import 'package:ticket_master/utils/all_constant.dart';
import 'package:ticket_master/utils/widgets_util.dart';

class MapWidgets extends StatefulWidget {
  @override
  State<MapWidgets> createState() => _MapWidgetsState();
}

class _MapWidgetsState extends State<MapWidgets> {
  // default constructor
  MapController controllerM = MapController(
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  var textEditingController = TextEditingController();

  List<GeoPoint> markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: AppColor.colorSecond(),
                //border: Border.all(color: AppColor.colorSecond(), width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
              ),
              child: Stack(
                children: [
                  OSMFlutter(
                      controller: controllerM,
                      onMapIsReady: (v) async {
                        print("ffs244 ${v}");
                        gotoPosition();
                      },
                      osmOption: OSMOption(
                        userTrackingOption: UserTrackingOption(
                          enableTracking: false,
                          unFollowUser: false,
                        ),
                        zoomOption: ZoomOption(
                          initZoom: 18,
                          minZoomLevel: 3,
                          maxZoomLevel: 19,
                          stepZoom: 1.0,
                        ),
                        userLocationMarker: UserLocationMaker(
                          personMarker: MarkerIcon(
                            icon: Icon(
                              Icons.location_history_rounded,
                              color: Colors.red,
                              size: 48,
                            ),
                          ),
                          directionArrowMarker: MarkerIcon(
                            icon: Icon(
                              Icons.double_arrow,
                              size: 48,
                            ),
                          ),
                        ),
                        roadConfiguration: RoadOption(
                          roadColor: Colors.yellowAccent,
                        ),
                        /*markerOption: MarkerOption(
                                defaultMarker: MarkerIcon(
                              icon: Icon(
                                Icons.person_pin_circle,
                                color: Colors.blue,
                                size: 56,
                              ),
                            )),*/
                      )),
                  FutureBuilder<String>(
                    future: CommonOperation.getSharedData(AllConstant.CURRENT_LIST_INDEX + AllConstant.PLACE, "SofFi Stadium"),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            putLatLong(AllConstant.CURRENT_LIST_INDEX + AllConstant.PLACE, "SofFi Stadium");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                            child: Container(
                              child: Text(snapshot.data!,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize:
                                          PrefUtil.preferences!.getDouble(AllConstant.CURRENT_LIST_INDEX + AllConstant.IncreaseDecreaseFontSecond) ??
                                              20,
                                      fontFamily: "metropolis",
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38)),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: Text("Get Directions",
                      style: TextStyle(fontSize: 16, fontFamily: "metropolis", fontWeight: FontWeight.normal, color: Colors.white)),
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
                  onLongPress: () {
                    putLatLong(AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG, "23.42424,92.8787");
                  },
                  onPressed: () async {
                    String? latLong = await PrefUtil.preferences!.getString(AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG);

                    if (latLong == null || latLong.isEmpty) return;

                    final availableMaps = await MapLauncher.installedMaps;
                    print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                    await availableMaps.first.showMarker(
                      coords: Coords(double.parse(latLong.split(",")[0]), double.parse(latLong.split(",")[1])),
                      title: "Basundara",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> gotoPosition() async {
    String? valueT = await PrefUtil.preferences!.getString("${AllConstant.CURRENT_LIST_INDEX + AllConstant.LAT_LONG}");
    if (valueT == null)
      return;
    else {
      for (GeoPoint marker in markers) {
        await controllerM.removeMarker(marker);
      }
      markers.clear(); // Clear the list after removing all markers

      double lat = double.parse(valueT.split(",")[0]);
      double long = double.parse(valueT.split(",")[1]);

      GeoPoint geoPoint = GeoPoint(latitude: lat, longitude: long);

      markers.add(geoPoint); // Keep track of markers
      await controllerM.moveTo(
        geoPoint,
        animate: true,
        //padding: EdgeInsets.only(top: 100),  // Add padding so the geoPoint is visible
      );
      await controllerM.addMarker(
        geoPoint,
        markerIcon: MarkerIcon(
          iconWidget: Image.asset(
            "assets/images/map_icon_marker.png",
            width: 40,
            height: 40,
          ),
        ),
      );
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
      gotoPosition();
    });
  }

  // Function to remove all markers by iterating through them
  void removeAllMarkers() async {
    for (GeoPoint marker in markers) {
      await controllerM.removeMarker(marker);
    }
    markers.clear(); // Clear the list after removing all markers
  }
}
