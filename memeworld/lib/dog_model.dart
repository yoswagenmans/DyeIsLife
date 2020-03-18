import 'dart:convert';
import 'dart:io';
class Dog {


  final String name;
  final String location;
  final String description;
  String imageUrl;

  // All dogs start out at 10, because they're good dogs.
  int rating = 10;

  Dog(this.name, this.location, this.description);

// dog_model.dart

Future getImageUrl() async {
  // Null check so our app isn't doing extra work.
  // If there's already an image, we don't need to get one.
  if (imageUrl != null) {
    return;
  }

  // This is how http calls are done in flutter:
  HttpClient http = HttpClient();
  try {
    // Use darts Uri builder
    var uri = Uri.http('dog.ceo', '/api/breeds/image/random');
    var request = await http.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // The dog.ceo API returns a JSON object with a property
    // called 'message', which actually is the URL.
    imageUrl = json.decode(responseBody)['message'];
  } catch (exception) {
    print(exception);
  }
}
}