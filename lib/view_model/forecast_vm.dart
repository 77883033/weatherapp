import 'package:get/get.dart';
import 'package:weather_application/models/forecast_model.dart';
import 'package:weather_application/services/http_services.dart';

class ForecastVM extends GetxController {
  bool isLoading = false;
  List<ForecastModel> forecastData = [];
  List<ForecastModel> dailyForecastData = [];

  vmGetForecastData() async {
    try {
      isLoading = true;
      update();
      forecastData = await HttpServices().fetchForecastData();
      dailyForecastData = await HttpServices().fetchForecastData();
      update();
      isLoading = false;
      update();
    }catch(e) {
      print(e);
      return [];
    }
  }
}