import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  GoogleMapController? _controller;

  final CameraPosition _initialPosition = CameraPosition(
  target: LatLng(-29.16203, -59.26075),
  zoom: 18.0
);

final Set <Marker> _markers = {
  Marker( markerId: MarkerId("Pepito"),
  position: LatLng(-29.16203, -59.26075),
  infoWindow: InfoWindow( title: "Lugar")
   )
};
 
  void addMarker(LatLng latLng) async{
    TextEditingController _textEditingController = TextEditingController();

    String? title = await showDialog<String>(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Titulo"),
        content: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: "Lugar",),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(null), child: Text("Cancela")),
          TextButton(onPressed: () => Navigator.of(context).pop(_textEditingController.text), child: Text("Guardar")),
        ],
      );
    });
    if(title != null && title.isNotEmpty){
      setState(() {
        _markers.add(
        Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(title: title),
          ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa Guapo"),
      ),
      body: GoogleMap(initialCameraPosition: _initialPosition,
      onMapCreated: (controller){
        _controller = controller;
      },
      mapType: MapType.normal,
      markers: _markers,
      onTap: (LatLng) => addMarker(LatLng),
      ),
    );
  }
  

}