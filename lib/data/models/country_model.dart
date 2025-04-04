class CountryModel {
  final String name;
  final String capital;
  final String region;
  final int population;
  final String flag;

  CountryModel({
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
    required this.flag,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'] ?? '',
      capital: (json['capital'] as List?)?.first ?? '',
      region: json['region'] ?? '',
      population: json['population'] ?? 0,
      flag: json['flags']['png'] ?? '',
    );
  }
}