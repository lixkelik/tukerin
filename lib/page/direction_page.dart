import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tukerin/constant_builder.dart';
import 'package:tukerin/page/widgets/appTheme.dart';
import 'package:tukerin/page/widgets/get_distance.dart';


// ignore: must_be_immutable
class DirectionPage extends StatefulWidget {
  String name;
  String address;
  double latitude;
  double longitude;

  DirectionPage(
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    {super.key}
  );

  @override
  // ignore: no_logic_in_create_state
  State<DirectionPage> createState() => _DirectionPageState(name, latitude, longitude);
}

class _DirectionPageState extends State<DirectionPage> {
  final String _name;
  final double _latitude;
  final double _longitude;
 

  _DirectionPageState(
    this._name, 
    this._latitude, 
    this._longitude,
  );

  LatLng _currLoc = const LatLng(-6.175835, 106.827158);

  GoogleMapController? _googleMapController;
  List<LatLng> polylineCoordinates = [];
  String distance = '0';

  @override
  void dispose(){
    _googleMapController?.dispose();
    polylineCoordinates.clear();
    super.dispose();
  }

  @override
  void initState(){ 
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            popAwait();
          },
           icon: const Icon(Icons.arrow_back_rounded)
        ),
        title: const Text(
          'Directions',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: appColor,
      ),
      
      body:Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: (controller){
                    _googleMapController = controller;
                  },
                  
                  compassEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(target: LatLng(_currLoc.latitude, _currLoc.longitude), zoom: 14),
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: polylineCoordinates,
                      color: appColor,
                      width: 6
                    ),
                  },
                  
                  markers: {
                    Marker(
                      markerId: const MarkerId('destination'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                      position: LatLng(_latitude, _longitude),
                    )
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: 85,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: appColor,
                  ),
                  child: Column(
                    children: [
                      Text(
                        _name,
                        style: const TextStyle(
                          height: 1.2,
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600
                          ),
                      ),
                      const Text(
                        'Distance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$distance Km',
                        style: const TextStyle(
                          height: 1.1,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getPolyPoints() async{
    polylineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDIRNyaUOlF0wH2sWHKvOL8yiCrmf5Rqqw', 
      PointLatLng(_currLoc.latitude, _currLoc.longitude), 
      PointLatLng(_latitude, _longitude),
    );

    if(result.points.isNotEmpty){
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }

    double totDistance = 0;
    if(polylineCoordinates.isNotEmpty){
      for(var i = 0; i < polylineCoordinates.length-1; i++){
        totDistance += getDistance(
          polylineCoordinates[i].latitude, 
          polylineCoordinates[i].longitude, 
          polylineCoordinates[i+1].latitude, 
          polylineCoordinates[i+1].longitude
        );
      }
    }
    
    setState(() {
      distance = totDistance.toStringAsPrecision(2);
    });
  }

  popAwait() async{
    Navigator.of(context).push(MaterialPageRoute(builder: (_) 
      => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Please wait',
                style: textStyle(25, bold, greyText),
              ),
            ),
            const SizedBox(height: 20,),
            const CircularProgressIndicator(),
          ],
        ),
      )));
    await Future.delayed(const Duration(milliseconds: 1000));
    // ignore: use_build_context_synchronously
    Navigator.of(context)
    ..pop()
    ..pop();
  }

  fetchLocation() async {
    Location location = Location();
    LocationData curr = await location.getLocation();
    setState(() {
      _currLoc = LatLng(curr.latitude!, curr.longitude!);
      
      getPolyPoints();
      _googleMapController!.animateCamera(CameraUpdate.newLatLng(
         _currLoc
      ));
    });
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currLoc = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
    
    
  }
}