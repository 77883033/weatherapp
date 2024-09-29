import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_application/constants/contant.dart';
import 'package:weather_application/goggle.dart';
import 'package:weather_application/view_model/forecast_vm.dart';

class WeatherSearch extends StatefulWidget {
  const WeatherSearch({super.key});

  @override
  State<WeatherSearch> createState() => _WeatherSearchState();
}

class _WeatherSearchState extends State<WeatherSearch> {
  final ForecastVM cs = Get.find<ForecastVM>();
  final TextEditingController _controller = TextEditingController();
  String currentSearch = "";

  @override
  void initState() {
    super.initState();
    cs.vmGetForecastData(); // Fetch initial data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForecastVM>(builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffeeaeca), Color(0xff94bbe9)],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [

                  Text(
                    'Weather',
                    style: myStyle(35, Colors.white, FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 380,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70,
                      ),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded),
                          hintText: currentSearch.isEmpty ? 'Search for a city' : currentSearch,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentSearch = value; // Update the current search input
                          });
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            cs.vmGetForecastData(); // Fetch data by city
                            _controller.clear(); // Clear the input
                            setState(() {
                              currentSearch = ""; // Reset the search input after submission
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
