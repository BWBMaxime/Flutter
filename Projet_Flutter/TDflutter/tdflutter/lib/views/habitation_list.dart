import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tdflutter/services/habitation_service.dart';
import 'package:tdflutter/views/habitation_details.dart';
import 'package:tdflutter/views/share/habitation_features_widget.dart';
import 'package:tdflutter/views/share/habitation_option.dart';
import '../models/Habitation.dart';

class HabitationList extends StatelessWidget {
  final HabitationService service = HabitationService();
  late List<Habitation> _habitations;
  final bool isHouseList;
  HabitationList(this.isHouseList, {Key? key}) {
    _habitations =
        isHouseList ? service.getMaisons() : service.getAppartements();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des ${isHouseList ? 'maison' : 'appartements'}"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _habitations.length,
          itemBuilder: (context, index) =>
              _buildRow(_habitations[index], context),
          itemExtent: 285,
        ),
      ),
    );
  }

  _buildRow(Habitation habitation, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HabitationDetails(habitation),
            ),
          );
        },
      ),
    );
  }

  _buildDetails(Habitation habitation) {
    var format = NumberFormat("### €");
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  title: Text(habitation.libelle),
                  subtitle: Text(habitation.adresse),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  format.format(habitation.prixmois),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 22),
                ),
              ),
            ],
          ),
          HabitationFeaturesWidget(habitation),
        ],
      ),
    );
  }
}
