import 'package:flutter/material.dart';
import 'package:travel_go/util/fetch_details.dart';
import 'package:travel_go/widgets/food_image_carousel.dart';
import 'package:travel_go/widgets/gradient_text.dart';
import 'package:travel_go/widgets/items_to_pack.dart';
import 'package:travel_go/widgets/place_image_carousel.dart';
import 'package:travel_go/widgets/weather_loader.dart';
// import 'package:pexels_api/pexels_api.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.queryPlace});
  final String queryPlace;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPlaceDetails(queryPlace),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset('assets/gifs/travel_load.gif',fit: BoxFit.cover,),
            
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: AnimatedGradientText(
              text: 'An Error Occured :( ',
              startColor: Color.fromARGB(255, 49, 130, 244),
              endColor: Color.fromARGB(255, 255, 25, 25),
              duration: Duration(milliseconds: 400),
              delay: 0,
            ),
          );
        } else if (snapshot.hasData) {
          final placeDetails = snapshot.data!;
          final placeName = placeDetails["queryPlace"];
          if (placeDetails["valid"] == false) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AnimatedGradientText(
                    text: placeName,
                    startColor: const Color.fromARGB(255, 84, 210, 227),
                    endColor: const Color.fromARGB(255, 255, 47, 47),
                    duration: const Duration(milliseconds: 600),
                    delay: 400,
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      placeDetails["url"],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/gifs/error.gif',
                          fit: BoxFit.scaleDown,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding: const EdgeInsets.all(10), // Add some padding
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface,
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    placeDetails["summary"], 
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurface,
                    ), 
                  ),
                ),
              ]),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AnimatedGradientText(
                    text: placeName,
                    startColor: const Color.fromARGB(255, 84, 210, 227),
                    endColor: const Color.fromARGB(255, 255, 47, 47),
                    duration: const Duration(milliseconds: 600),
                    delay: 200,
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      placeDetails["url"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(

                  padding: const EdgeInsets.all(10), 
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface,
                    borderRadius: BorderRadius.circular(10), 
                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    placeDetails["summary"], 
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                WeatherLoader(queryPlace: placeName),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: AnimatedGradientText(
                      text: "Places To Visit",
                      startColor: Color.fromARGB(255, 84, 210, 227),
                      endColor: Color.fromARGB(255, 255, 47, 47),
                      duration: Duration(milliseconds: 600),
                      delay: 500),
                ),
                PlaceImageCarousel(placeDetailsObjList: placeDetails["places"]),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: AnimatedGradientText(
                      text: "Local Specialties",
                      startColor: Color.fromARGB(255, 84, 210, 227),
                      endColor: Color.fromARGB(255, 255, 47, 47),
                      duration: Duration(milliseconds: 600),
                      delay: 500),
                ),
                FoodImageCarousel(foodDetailsObjList: placeDetails["food"]),
                const SizedBox(
                  height: 12,
                ),
                ItemsToPack(itemsList: placeDetails["items"]),
              ]),
            );
          }
        } else {
          return const Center(
            child: AnimatedGradientText(
              text: 'Couldn\'t Find What You Are Looking For',
              startColor: Color.fromARGB(255, 49, 130, 244),
              endColor: Color.fromARGB(255, 244, 49, 98),
              duration: Duration(milliseconds: 400),
              delay: 0,
            ),
          );
        }
      },
    );
  }
}
