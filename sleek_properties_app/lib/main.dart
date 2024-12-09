import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/property_event.dart';
import 'services/property_service.dart';
import 'bloc/property_bloc.dart';
import 'pages/property_list_page.dart';

void main() {
  runApp(PropertyApp());
}

class PropertyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyBloc(PropertyService())..add(FetchProperties()), // Initialize PropertyBloc with PropertyService
      child: MaterialApp(
        title: 'Property Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: PropertyListPage(),
      ),
    );
  }
}
