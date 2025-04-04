import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/dependencies.dart';
import '../../../data/models/custom_country_model.dart';

class CustomCountryCard extends StatelessWidget {
  final CustomCountryModel country;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomCountryCard({
    Key? key,
    required this.country,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.blue[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  country.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            Text('Capital: ${country.capital}'),
            Text('Region: ${country.region}'),
            Text('Population: ${NumberFormat.decimalPattern().format(country.population)}'),
          ],
        ),
      ),
    );
  }
}