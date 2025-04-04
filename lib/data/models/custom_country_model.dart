import 'package:cloud_firestore/cloud_firestore.dart';

class CustomCountryModel {
  final String? id;
  final String name;
  final String capital;
  final String region;
  final int population;
  final DateTime createdAt;

  CustomCountryModel({
    this.id,
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
    required this.createdAt,
  });

  factory CustomCountryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomCountryModel(
      id: doc.id,
      name: data['name'],
      capital: data['capital'],
      region: data['region'],
      population: data['population'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capital': capital,
      'region': region,
      'population': population,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}