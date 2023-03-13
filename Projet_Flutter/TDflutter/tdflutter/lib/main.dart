import 'package:flutter/material.dart';
import 'package:tdflutter/models/Habitation.dart';
import 'package:tdflutter/models/typehabitat.dart';
import 'package:tdflutter/services/habitation_service.dart';
import 'package:tdflutter/share/location_style.dart';
import 'package:tdflutter/share/location_text_style.dart';
import 'package:tdflutter/views/habitation_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mes locations'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final HabitationService service = HabitationService();
  final String title;
  late List<TypeHabitat> _typehabitats;
  late List<Habitation> _habitations;
  MyHomePage({required this.title, Key? key}) : super(key: key) {
    _habitations = service.getHabitationsTop10();
    _typehabitats = service.getTypeHabitats();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildTypeHabitat(context),
            const SizedBox(height: 30),
            _buildDerniereLocation(context)
          ],
        ),
      ),
    );
  }

  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _typehabitats.length,
          (index) => _buildHabitat(context, _typehabitats[index]),
        ),
      ),
    );
  }

  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HabitationList(typeHabitat.id == 1),
              ),
            );
          }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70),
              const SizedBox(
                width: 5,
              ),
              Text(
                typeHabitat.libelle,
                style: LocationTextStyle.regularWithTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildDerniereLocation(BuildContext context) {
    return Container(
      height: 248,
      child: ListView.builder(
        itemCount: _habitations.length,
        itemExtent: 220,
        itemBuilder: (context, index) =>
            _buildRow(_habitations[index], context),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            habitation.libelle,
            style: LocationTextStyle.regularTextStyle,
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              Text(
                habitation.adresse,
                style: LocationTextStyle.regularTextStyle,
              ),
            ],
          ),
          Text(
            habitation.prixmois.toString(),
            style: LocationTextStyle.boldTextStyle,
          )
        ],
      ),
    );
  }
}
