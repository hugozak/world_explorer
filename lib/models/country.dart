class Country {
  String name;
  String currency;
  String currencySymbol;
  String capital;
  double population;
  String flagLink;

  Country({
    required this.name, 
    required this.currency, 
    required this.currencySymbol, 
    required this.capital, 
    required this.population, 
    required this.flagLink
    });
  
  factory Country.fromJson(Map<String, dynamic> json){
    return Country(
      name: json['translations']['fra']['common'],
      currency: json['currencies'] != null && json['currencies'].isNotEmpty ? json['currencies'].values.first['name'] : 'Pas de monnaie',
      currencySymbol: json['currencies'] != null && json['currencies'].isNotEmpty ? json['currencies'].values.first['symbol'] : 'Pas de monnaie',
      capital: json['capital'] != null && json['capital'].isNotEmpty ? json['capital'][0] : "Pas de capitale",
      population: json['population'],
      flagLink: json['flags']['png']
    );
  }

  factory Country.fromJsonClear(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      currency: json['currency'],
      currencySymbol: json['currencySymbol'],
      capital: json['capital'],
      population: json['population'],
      flagLink: json['flagLink']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'capital': capital,
      'population': population,
      'flagLink': flagLink
    };
  }
}