import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tukerin/constant_builder.dart';
import 'package:tukerin/models/station.dart';
import 'package:tukerin/page/direction_page.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as stat;
import 'package:tukerin/page/payment_page.dart';
import 'package:tukerin/page/widgets/appTheme.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  Station station;
  LatLng currLoc;

  DetailScreen(this.station, this.currLoc,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DetailScreen> createState() => _DetailScreenState(station, currLoc);
}

class _DetailScreenState extends State<DetailScreen> {
  final Station station;
  final LatLng _currLoc;

  _DetailScreenState(
    this.station,
    this._currLoc,
  );

  String distance = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Swap Station Details',
          style: TextStyle(fontWeight: bold),
        ),
        backgroundColor: appColor,
      ),
      body: Stack(
        children: [
          Image.network(
            station.image,
            width: MediaQuery.of(context).size.width,
            height: 190,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              const SizedBox(
                height: 170,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: white),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        station.name,
                        style: textStyle(25, semiBold, darkerGrey)
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        station.address,
                        style: textStyle(14, medium, greyText)
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Directions',
                        style: textStyle(17, medium, darkerGrey)
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '${station.distance!.toStringAsFixed(1)} Km From you',
                        style: textStyle(16, regular, greyText)
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: lightGrey
                      ),
                      child: InkWell(
                        onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DirectionPage(station.name, station.address,
                            station.latitude,station.longitude, _currLoc)),);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: stat.StaticMap(
                            googleApiKey:
                                'AIzaSyDIRNyaUOlF0wH2sWHKvOL8yiCrmf5Rqqw',
                            center: stat.Location(station.latitude, station.longitude),
                            zoom: 14,
                            scaleToDevicePixelRatio: true,
                            markers: [
                              stat.Marker(
                                color: appColor,
                                locations: [
                                  stat.GeocodedLocation.latLng(station.latitude, station.longitude)
                                ]
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Available Batteries',
                        style: textStyle(18, medium, darkerGrey)
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.5),
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Gesits Battery',
                            style: textStyle(17, medium, white)
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 28),
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 2).format(station.price),
                            style: textStyle(15, medium, white)
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 54),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => PaymentPage(station)),
                                );
                              },
                              style: buttonStyle2,
                              child: Center(
                                child: Text(
                                  'SWAP!',
                                  style: textStyle(18, bold, darkerGrey)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
