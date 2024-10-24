// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

// import 'package:travel_go/widgets/weather.dart';
// import 'package:travel_go/widgets/weather.dart';

// Future<Map<String, dynamic>>

Future<Map<String, dynamic>> fetchPlaceDetails(String queryPlace) async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyCDT_HpaJh6rFPpO1kfsD16t5fWWL1hn6Q',
    generationConfig: GenerationConfig(
      temperature: 0.3,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
    ),
    systemInstruction: Content.system('JSON only'),
  );

  final chat = model.startChat(history: [
    Content.multi([
      TextPart('You are a reliable travel guide. When you are given a name of a village, town, city , state, country, continent or any tourist place , you reply with only a json of  1) a short summary of the place of no more than 30 words, along with 2) url- leave this blank . Additionally you reply with top famous three food specialities in a list (preferably breakfast , main course ,dessert , without explicitly mentioning its breakfast main course or dessert) of that location that includes dish name, dish image url- leave this blank in json, and short description of no more than 20 words. Also include a list of 7 important items to carry for traveling there. finally include a list of 4 objects for top 4 most visited and liked places or cultural heritages in that location that contains name of location, a url- leave this blank- for top rated pic of that location, and a short description of no more than 10 words.If its a common noun of a place/location, then suggest the best place for it. If it\'s a fiction based place or location, then provide the required information according to said fiction with images based on it, but the fiction should be an existing fiction in human realm- novels, stories, mythologies ,etc with exact same reference, word for word, strictly. If it has no previous mention in history or looks made up on spot then it\'s invalid. Its INVALID  even if it\'s just a fictional character and not a valid place in fiction .  If no valid place is found (or invalid condition is true) just include a variable valid: false in json and  food ,places,items,url should be empty, while still giving a summary  of less than 15 words + friendly joke specifically for it not being a place. valid is true if place is valid or in existing fiction. also include a variable isFiction: true or false in the json object as well. '),
      TextPart('bangalore\n'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Bangalore, also known as Bengaluru, is a vibrant city in India known for its tech industry, parks, and delicious food.", "url": "", "food": [{"dish": "Idli and Sambar", "dish_image_url": "", "description": "Steamed rice cakes served with a lentil stew"}, {"dish": "Mysore Masala Dosa", "dish_image_url": "", "description": "Crispy dosa filled with spiced potatoes and onions"}, {"dish": "Bisi Bele Bath", "dish_image_url": "", "description": "Spicy rice dish with lentils, vegetables, and a tangy yogurt sauce"}], "items": ["Comfortable shoes", "Sunscreen", "Insect repellent", "Light clothing", "Water bottle", "Camera", "Travel adapter"], "places": [{"name": "Bangalore Palace", "url": "", "description": "A majestic palace inspired by Windsor Castle"}, {"name": "Lalbagh Botanical Garden", "url": "", "description": "A sprawling garden with diverse flora"}, {"name": "ISKCON Temple", "url": "", "description": "A beautiful temple dedicated to Lord Krishna"}, {"name": "Cubbon Park", "url": "", "description": "A green oasis in the heart of the city"}], "valid": true, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('e\n'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "The letter \'e\' is one of the most common letters in the English alphabet, appearing in countless words. You can\'t visit it though ?", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('the vast plains of vasco parantheses 2\n'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "The vast plains of Vasco Parentheses 2 is a fictional location, likely from a book or game. You could probably visit in in your dreamland .", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('unprob island of seashore\n'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Unprob Island of Seashore is a fictional location, likely from a book or game. It\'s a place where you can let your imagination run wild!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('chamber of secrets'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "The Chamber of Secrets is a hidden chamber beneath Hogwarts School of Witchcraft and Wizardry, featured in J.K. Rowling\'s Harry Potter series. It\'s a dangerous place filled with secrets and a giant snake.", "url": "", "food": [{"dish": "Treacle Tart", "dish_image_url": "", "description": "A sweet and sticky dessert popular in Britain"}, {"dish": "Roast Beef and Yorkshire Pudding", "dish_image_url": "", "description": "A traditional British meal with tender roast beef and fluffy Yorkshire pudding"}, {"dish": "Spotted Dick", "dish_image_url": "", "description": "A steamed pudding with dried fruit and a sweet sauce"}], "items": ["Wand", "Invisibility Cloak", "Flying Car", "Magical Creatures Guide", "Potions Book", "Map of Hogwarts", "Chocolate Frogs"], "places": [{"name": "The Chamber of Secrets", "url": "", "description": "A hidden chamber beneath Hogwarts"}, {"name": "The Great Hall", "url": "", "description": "The main dining hall of Hogwarts"}, {"name": "The Forbidden Forest", "url": "", "description": "A mysterious forest surrounding Hogwarts"}, {"name": "The Room of Requirement", "url": "", "description": "A magical room that appears when needed"}], "valid": true, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('tarzan'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Tarzan is a fictional character created by Edgar Rice Burroughs, known for his adventures in the African jungle. How do u visit humans ,I wonder!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('mowgli'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Mowgli is a fictional character from Rudyard Kipling\'s \'The Jungle Book\', a young boy raised by wolves in the Indian jungle.  You can\'t visit him, but you can visit India!", "url": "", "food": [{"dish": "Samosas", "dish_image_url": "", "description": "Crispy fried pastries filled with spiced potatoes and peas"}, {"dish": "Chicken Tikka Masala", "dish_image_url": "", "description": "A creamy and flavorful curry dish with marinated chicken"}, {"dish": "Gulab Jamun", "dish_image_url": "", "description": "Sweet and spongy milk balls soaked in sugar syrup"}], "items": ["Comfortable shoes", "Sunscreen", "Insect repellent", "Light clothing", "Water bottle", "Camera", "Travel adapter"], "places": [{"name": "Taj Mahal", "url": "", "description": "A stunning white marble mausoleum"}, {"name": "The Ganges River", "url": "", "description": "A sacred river in Hinduism"}, {"name": "The Himalayas", "url": "", "description": "A majestic mountain range"}, {"name": "The Golden Temple", "url": "", "description": "A beautiful Sikh temple"}], "valid": true, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('hercule poirat'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Hercule Poirot is a fictional detective created by Agatha Christie, known for his brilliant mind and eccentric personality. He\'s a fictional character, so you can\'t visit him.", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('mammals'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Mammals are a diverse class of warm-blooded vertebrates that includes humans, dogs, cats, whales, and many more. You can\'t visit them, but you can visit zoos or wildlife sanctuaries.", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('botanical gardens'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Botanical gardens are serene oases showcasing diverse plant species, offering educational and recreational opportunities. ", "url": "", "food": [{"dish": "Fruit Salad", "dish_image_url": "", "description": "A refreshing mix of fresh fruits"}, {"dish": "Quiche", "dish_image_url": "", "description": "A savory pastry filled with eggs, cheese, and vegetables"}, {"dish": "Lemon Sorbet", "dish_image_url": "", "description": "A light and refreshing frozen dessert"}], "items": ["Comfortable shoes", "Camera", "Water bottle", "Sunscreen", "Hat", "Binoculars", "Notebook"], "places": [{"name": "Royal Botanic Gardens, Kew", "url": "", "description": "World-renowned gardens in London"}, {"name": "Missouri Botanical Garden", "url": "", "description": "A beautiful garden in St. Louis"}, {"name": "Singapore Botanic Gardens", "url": "", "description": "A UNESCO World Heritage Site"}, {"name": "New York Botanical Garden", "url": "", "description": "A vast garden in the Bronx"}], "valid": true, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('miau miau miau miau'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Miau miau miau miau sounds like a cat trying to tell you something. Maybe it\'s hungry, or wants to play. You should try searching for cat cafes!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('miau miau'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Miau miau sounds like a cat trying to tell you something. Maybe it\'s hungry, or wants to play. You should try searching for cat cafes!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('awwooooooooooo'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Awwooooooooooo sounds like a wolf howling at the moon.  You can\'t visit a wolf howl, but you can visit a zoo or wildlife sanctuary!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('1+1'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "1+1 is a simple math problem. The answer is 2. Have you considered using a calculator?", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('100-23'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "100-23 is a simple subtraction problem. The answer is 77.  Have you considered using a calculator?", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('hi\n'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Hi! How can I help you today?  I\'m a travel guide, so tell me where you\'d like to go!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('harry potter'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Harry Potter is a fictional wizarding boy, the main character in J.K. Rowling\'s beloved series. You can\'t visit him, but you can visit the Wizarding World of Harry Potter theme parks!", "url": "", "food": [{"dish": "Treacle Tart", "dish_image_url": "", "description": "A sweet and sticky dessert popular in Britain"}, {"dish": "Roast Beef and Yorkshire Pudding", "dish_image_url": "", "description": "A traditional British meal with tender roast beef and fluffy Yorkshire pudding"}, {"dish": "Spotted Dick", "dish_image_url": "", "description": "A steamed pudding with dried fruit and a sweet sauce"}], "items": ["Wand", "Invisibility Cloak", "Flying Car", "Magical Creatures Guide", "Potions Book", "Map of Hogwarts", "Chocolate Frogs"], "places": [{"name": "Hogwarts Castle", "url": "", "description": "The magical school for witches and wizards"}, {"name": "Diagon Alley", "url": "", "description": "A hidden wizarding shopping street"}, {"name": "The Forbidden Forest", "url": "", "description": "A mysterious forest surrounding Hogwarts"}, {"name": "The Room of Requirement", "url": "", "description": "A magical room that appears when needed"}], "valid": true, "isFiction": true}\n\n```'),
    ]),
    Content.multi([
      TextPart('wizards\n'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Wizards are magical beings who can perform spells and potions. You can\'t visit them.", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
    Content.multi([
      TextPart('hehe'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Hehe!  Would you mind the funny place for Travellers you are thinking about?", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n\n```'),
    ]),
    Content.multi([
      TextPart('train'),
    ]),
    Content.model([
      TextPart('```json\n{"summary": "Trains are a common mode of transportation, offering journeys across various landscapes. You can\'t visit a train, but you can visit a train museum!", "url": "", "food": [], "items": [], "places": [], "valid": false, "isFiction": false}\n\n```'),
    ]),
  ]);

  final content = Content.text(queryPlace);
  final response = await chat.sendMessage(content);
  if (response.text == null) {
    return {"error": "Failed to fetch data"};
  }
  final placeDetails = json.decode(response.text!);

  final placeImgRes = await http.get(Uri.parse(
      'https://pixabay.com/api/?key=46683596-b16f1817ff2cbb6fde4c6971a&q=$queryPlace&image_type=photo&per_page=3'));
  final placeResJson = jsonDecode(placeImgRes.body);
  if (placeResJson["total"]>0) {
    String placeImgUrl = placeResJson["hits"][0]["webformatURL"];
    placeDetails["url"] = placeImgUrl;
  }

  if (placeDetails["valid"] == true) {
    for (var place in placeDetails['places']) {
      String name = place["name"];
      name = name.replaceAll(" ", "+");
      final response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=46683596-b16f1817ff2cbb6fde4c6971a&q=$name&image_type=photo&per_page=3'));
      final responseJson = jsonDecode(response.body);
      String imgUrl = responseJson["hits"][0]["webformatURL"];
      place["url"] = imgUrl;
    }

    for (var dish in placeDetails['food']) {
      String dishName = dish["dish"];
      dishName = dishName.replaceAll(" ", "+");
      final response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=46683596-b16f1817ff2cbb6fde4c6971a&q=$dishName&image_type=photo&per_page=3'));
      final responseJson = jsonDecode(response.body);
      String imgUrl = responseJson["hits"][0]["webformatURL"];
      dish["dish_image_url"] = imgUrl;
    }
  }
  return placeDetails;
}


// Future<Map<String, dynamic>> fetchPlaceData(String queryPlace) async {
//   String url =
//       'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyCDT_HpaJh6rFPpO1kfsD16t5fWWL1hn6Q';
//   String body = json.encode({
//     "contents": [
//       {
//         "parts": [
//           {
//             "text":
//                 "Reply in dictionary form.You are a reliable travel guide. When you are given a name of a village, town, city , state, country, continent or any tourist place , you reply with only a json of  1) a short summary of the place of no more than 30 words, along with 2) an image link for the place . Additionally you reply with top famous three food specialities of that location that includes dish name, dish image url, and short description of no more than 10 words. Also include a list of 7 important items to carry for traveling there. finally include a list of 4 objects for top 4 most visited and liked places or cultural heritages in that location that contains name of location, image url for top rated pic of that location, and a short description of no more than 10 words. if no valid place is found replace image with sad smiley image links, descriptions with random family friendly jokes about how user tried to ask you about a place that doesn't exist  , and replace names with synonyms of 'oops' or 'oh no' or other Exclamatory phrases of maximum 2 words . However, if it's a fiction based place, then provide the required information according to said fiction with images based on it. If it's not a fiction based place but has enough context then cook up a new fiction and reply accordingly, image generation is allowed. include a variable fiction: true or false in the json object as well. Input place : $queryPlace"
//           }
//         ]
//       }
//     ]
//   });
//   try {
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {"Content-Type": "application/json"},
//       body: body,
//     );
//     if (response.statusCode == 200) {
//       print("Request successful");
//       final jsonRes = json.decode(response.body);
//       final mapData = jsonRes["candidates"][0]["content"]["parts"][0]["text"];
//       return json.decode(mapData
//           .replaceAll("```json\n", "")
//           .replaceAll("```", "")); // Return decoded JSON map
//     } else {
//       print("Request failed with status: ${response.statusCode}");
//       return {"error": "Failed to fetch data"};
//     }
//   } catch (e) {
//     print("An error occurred: $e");
//     return {"error": "Exception occurred"};
//   }


  
// }










// final queryPlaceName = queryPlace.replaceAll(" ", "%");
//   final geoCodingUrl = Uri.parse(
//       'https://api.geoapify.com/v1/geocode/search?text=$queryPlaceName&apiKey=e696da94999747508e7a031760c921c6');
//   try {
//     final response = await http.get(geoCodingUrl);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['features'] is List && data['features'].isNotEmpty) {
        // Extract location data from the first feature (assuming one match)
//         final feature = data['features'][0];
//         final lat = feature['geometry']['coordinates'][0];
//         final lon = feature['geometry']['coordinates'][1];
//         final weatherUrl = Uri.parse(
//             'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,cloud_cover,relative_humidity_2m,apparent_temperature,weather_code,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset&forecast_days=3&wind_speed_unit=ms&timezone=auto');

//         final weatherResponse = await http.get(weatherUrl);
//         print(weatherResponse.body);
//         final weatherData = WeatherData.fromJson(jsonDecode(weatherResponse.body));
//         print(weatherData);
//       } else {
//         print('No results found for the provided address.');
//       }
//     } else {
//       print('Error fetching geocode data: ${response.statusCode}');
//     }
//   } catch (error) {
//     print('Error: $error');
//   }