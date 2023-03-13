import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../../models/Habitation.dart';
import 'package:tdflutter/views/share/habitation_option.dart';

class HabitationFeaturesWidget extends StatelessWidget {
  final Habitation _habitation;
  const HabitationFeaturesWidget(this._habitation,{key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HabitationOption("${_habitation.nbpersonnes} personnes", Icons.group),
        HabitationOption("${_habitation.chambres} chambres", Icons.bed),
        HabitationOption("${_habitation.superficie} m²", Icons.fit_screen),
      ],
    );
  }
}
