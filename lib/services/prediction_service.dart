// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PredictionService {
//   final String baseUrl;

//   PredictionService(this.baseUrl);

//   Future<String> fetchPrediction(dynamic inputData) async {
//     final url = Uri.parse('$baseUrl/predict');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'data': inputData}),
//     );

//     if (response.statusCode == 200) {
//       final prediction = jsonDecode(response.body)['prediction'];
//       return 'Prediction: $prediction';
//     } else {
//       throw Exception('Failed to load prediction');
//     }
//   }
// }
