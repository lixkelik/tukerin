import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Station{
  String image;
  String name;
  String address;
  int price;
  double? distance;
  double latitude;
  double longitude;
  LatLng currLoc;
  

  Station({
    required this.image,
    required this.name,
    required this.address,
    required this.price,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.currLoc,
  });

  factory Station.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Station(
      name: data['stationName'] ?? '',
      address: data['address'] ?? '',
      price: data['price1'] ?? 0,
      latitude: data['location'].latitude ?? 0.0,
      longitude: data['location'].longitude ?? 0.0,
      currLoc: const LatLng(0.0, 0.0),
      image: data['image'] ?? '', 
      distance: null,
    );
  }
}