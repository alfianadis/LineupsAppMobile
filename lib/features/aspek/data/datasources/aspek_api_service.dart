// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:lineups/features/aspek/data/models/aspek_model.dart';

// class AspekApiService {
//   final String baseUrl = "https://ninety-dolls-begin.loca.lt/";

//   Future<List<AspekModel>> getAspeks() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/aspect'));

//       if (response.statusCode == 200) {
//         Iterable jsonResponse = json.decode(response.body);
//         List<AspekModel> aspeks =
//             jsonResponse.map((model) => AspekModel.fromJson(model)).toList();
//         return aspeks;
//       } else {
//         throw Exception('Failed to load aspeks');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<AspekModel> createAspekModel(AspekModel aspekModel) async {
//     try {
//       var response = await http.post(
//         Uri.parse('$baseUrl/aspect'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(aspekModel.toJson()),
//       );

//       if (response.statusCode == 201) {
//         return AspekModel.fromJson(jsonDecode(response.body));
//       } else {
//         throw Exception('Failed to create aspect');
//       }
//     } catch (e) {
//       throw Exception('Failed to create aspect: $e');
//     }
//   }

//   Future<bool> updateAspek(AspekModel aspek) async {
//     try {
//       final response = await http.put(
//         Uri.parse(
//             '$baseUrl/aspect/${aspek.id}'), // Sesuaikan dengan endpoint update sesuai API Anda
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(aspek.toJson()),
//       );

//       if (response.statusCode == 200) {
//         return true; // Return true jika berhasil memperbarui
//       } else {
//         throw Exception('Failed to update aspek');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   Future<bool> deleteAspek(String id) async {
//     try {
//       final response = await http.delete(
//         Uri.parse(
//             '$baseUrl/aspect/$id'), // Sesuaikan dengan endpoint delete sesuai API Anda
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );

//       if (response.statusCode == 200) {
//         return true; // Return true jika berhasil menghapus
//       } else {
//         throw Exception('Failed to delete aspek');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }
