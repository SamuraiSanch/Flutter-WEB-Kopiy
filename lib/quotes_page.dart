import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuotesPage extends StatelessWidget {
  const QuotesPage({Key? key}) : super(key: key);

  Future<List<Map<String, String>>> fetchQuotes(int count) async {
    const String apiKey = 'TMsrbPJ3GVATdGy1OtX8jA==j9KvxSvsF4VnIhix';
    List<Map<String, String>> quotes = [];

    for (int i = 0; i < count; i++) {
      final apiUrl = 'https://api.api-ninjas.com/v1/quotes';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        quotes.add({
          'category': data[0]['category'].toString(),
          'quote': data[0]['quote'].toString(),
        });
      } else {
        quotes.add({
          'category': 'unknown',
          'quote': 'Failed to load quote',
        });
      }
    }

    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspiration Quotes'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchQuotes(5), // Отримуємо 5 випадкових цитат
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final quotes = snapshot.data!;
            return ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final category = quotes[index]['category'] ?? 'unknown';
                final quote = quotes[index]['quote'] ?? 'No quote available';
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '[$category]: $quote',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No quotes available'));
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
