import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/dependencies.dart';
import '../../../data/models/country_model.dart';

class CountryCard extends StatelessWidget {
  final CountryModel country;

  const CountryCard({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: country.flag,
                  width: 50,
                  height: 30,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.flag),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    country.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Capital: ${country.capital}'),
            Text('Region: ${country.region}'),
            Text('Population: ${NumberFormat.decimalPattern().format(country.population)}'),
          ],
        ),
      ),
    );
  }
}