import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tukerin/models/station.dart';
import 'package:tukerin/page/search_page1.dart';
import 'package:tukerin/page/widgets/ads_card.dart';
import 'package:tukerin/page/widgets/appTheme.dart';
import 'package:tukerin/constant_builder.dart';
import 'package:tukerin/page/widgets/get_distance.dart';
import 'package:tukerin/page/widgets/station_card.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:tukerin/main.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  LatLng _initialcameraposition = const LatLng(-6.175835, 106.827158);
  late List<stat.GeocodedLocation> markerList = [
    const stat.GeocodedLocation.latLng(0, 0),
  ];
  GoogleMapController? _googleMapController;
  
  LatLng userLatLng = const LatLng(-6.175835, 106.827158);

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  Location location = Location();
  bool isLocationServiceEnabled = false;
  late Future<List<Station>> stationList;
  @override
  void initState() {
    fetchLocation();
    getMarker();
    stationList = _getStations();
    _googleMapController?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _initialcameraposition, zoom: 14.5)));
    super.initState();
  }

  List<String> items =[
    'assets/img/adsImg/ads-2.jpg',
    'assets/img/adsImg/ads-1.jpg',
    'assets/img/adsImg/ads-3.jpg',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: darkGrey,
        ),
        toolbarHeight: 67,
        backgroundColor: appColor,
        elevation: 0,
        title: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchPage1(LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude))),
              );
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 40,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Text(
                    'Search swap station',
                    style: textStyle(16, medium, darkGrey)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/img/home_rectangle.png', fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
            Container(
              
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(top: 83),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    
                    height: MediaQuery.of(context).size.height * 0.42,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, bottom: 7, top: 12),
                          child: Text(
                            'Station around you',
                            style: textStyle(20, bold, black)
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: lightGrey
                          ),
                          child: InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: stat.StaticMap(
                                googleApiKey:'AIzaSyDIRNyaUOlF0wH2sWHKvOL8yiCrmf5Rqqw',
                                center: stat.Location(
                                    _initialcameraposition.latitude,
                                    _initialcameraposition.longitude),
                                zoom: 14,
                                scaleToDevicePixelRatio: true,
                                markers: [
                                  stat.Marker(
                                    size: stat.MarkerSize.mid,
                                    color: Colors.red,
                                    locations: [
                                      stat.GeocodedLocation.latLng(_initialcameraposition.latitude, _initialcameraposition.longitude),
                                    ]
                                  ),
                                  stat.Marker(
                                    size: stat.MarkerSize.small,
                                    color: purple,
                                    locations: markerList,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SearchPage1(LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude))),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 17),
                          child: Text(
                            'Your Motorcycle Type',
                            style: textStyle(16, semiBold, black)
                          ),
                        ),
                        Container(
                          height:MediaQuery.of(context).size.height * 0.065,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          decoration: BoxDecoration(
                            color: lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Gesits',
                            style: textStyle(15, semiBold, darkerGrey)
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 180,
                    width: 450,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (context, _) => const SizedBox(width: 5,),
                      itemBuilder: (context, index) => adsCard(items[index]),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Nearby Station',
                      style: textStyle(20, semiBold, darkerGrey)
                    ),
                  ),
                  FutureBuilder<List<Station>>(
                    future: stationList,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching stations'));
                      } else if (snapshot.hasData) {
                        final stations = snapshot.data!;
                        stations.sort((a, b) => a.distance!.compareTo(b.distance!));
                        return Column(
                          children: stations.map((station) => StationCard(station, userLatLng)).take(5).toList(),
                        );
                      } else {
                        return const Center(child: Text('No stations found'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetchLocation() async {
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _initialcameraposition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        
      });
    });
    
  }

  Future getMarker() async{
    await firestore.collection("station").get().then((querySnapshot){
      var fireBase = querySnapshot.docs;
      for(var i = 1; i < fireBase.length; i++){
        GeoPoint point = fireBase[i].data()['location'];
        markerList.add(
          stat.GeocodedLocation.latLng(double.parse('${point.latitude}'), 
          double.parse('${point.longitude}'))
        );
      }
    });
  }

  Future<List<Station>> _getStations() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('station').get();
    final stations = <Station>[];
    final userLocation = await location.getLocation();
    if(userLocation.latitude != null && userLocation.longitude != null){
      setState(() {
        userLatLng = LatLng(userLocation.latitude!, userLocation.longitude!);
        isLocationServiceEnabled == true;
      });
    }
    for (final docSnapshot in querySnapshot.docs) {
      final station = Station.fromSnapshot(docSnapshot);
      station.distance = getDistance(userLatLng.latitude, userLatLng.longitude, station.latitude, station.longitude,);
      
      stations.add(station);
    }
    return stations;
  }

}
