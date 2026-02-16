import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coffee Map')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51.509364, -0.128928), // London
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.coffee_frontend',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(51.509364, -0.128928),
                width: 80,
                height: 80,
                child: const Icon(Icons.location_on, color: Colors.brown, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
