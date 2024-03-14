class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  // ignore: slash_for_doc_comments
  /**
   * A factory constructor named 'fromJson'.
   * This constructor does not always create a new instance of its class,
   * but returns an instance from a JSON object.
   * It's used when you have a complex process to initialize an instance,
   * or when you want to return a cached instance, if available.
   * In this case, it's used to initialize a Weather instance from a JSON object.
   */
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}
