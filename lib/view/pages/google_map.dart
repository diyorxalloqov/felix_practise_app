import 'dart:async';

import 'package:felix_practise_app/view_model/bloc/practise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  final String title;
  final String description;
  const GoogleMapPage(
      {super.key, required this.description, required this.title});

  @override
  State<GoogleMapPage> createState() => MapSampleState();
}

class MapSampleState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  PolylinePoints polylinePoints = PolylinePoints();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.311081, 69.240562),
    zoom: 14.4746,
  );

  Location location = Location();
  Map<MarkerId, Marker> markers = {};
  late bool _serviceEnabled;

  late PermissionStatus _permissionGranted;

  late LocationData _locationData;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  void getMyLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(_locationData.latitude!, _locationData.longitude!),
            zoom: 19),
      ),
    );
    _addMarkers(LatLng(_locationData.latitude!, _locationData.longitude!),
        "My Location");
  }

  void _addMarkers(LatLng point, String markerName) {
    final MarkerId markerId = MarkerId(markerName);
    final Marker marker = Marker(
        markerId: markerId,
        position: point,
        infoWindow: InfoWindow(
          title: markerName,
          snippet: 'Marker Snippet',
        ),
        onTap: () {});

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    getMyLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (point) {
          _addMarkers(point, "Destination");
          _drawPolyline(
              initialPoint:
                  LatLng(_locationData.latitude!, _locationData.longitude!),
              destinationPoint: point);
          context.read<PractiseBloc>().add(SendApiAdress(
              title: widget.title ?? '',
              description: widget.description ?? '',
              lat: _locationData.latitude.toString(),
              long: _locationData.longitude.toString()));
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: const Text('send data')),
    );
  }

  Future<void> _goToTheMyLocation() async {
    LocationData newLocation = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              newLocation.latitude!,
              newLocation.longitude!,
            ),
            zoom: 20),
      ),
    );
  }

  Future<void> _drawPolyline(
      {required LatLng initialPoint, required LatLng destinationPoint}) async {
    polylines.clear();
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBxYMqIM6G4C5SIWroVFvbZ-7Qpu8AFOvM",
        PointLatLng(initialPoint.latitude, initialPoint.longitude),
        PointLatLng(destinationPoint.latitude, destinationPoint.longitude),
        travelMode: TravelMode.walking);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      PolylineId id = const PolylineId('polyline');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 4,
      );

      setState(() {
        polylines[id] = polyline;
      });
    }
  }
}
