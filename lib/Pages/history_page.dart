import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Components/navigation_bar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Placeholder for future dynamic data from your AI model
  final List<Map<String, dynamic>> translationHistory = List.generate(
    5,  // Number of placeholder boxes
    (_) => {'date': '', 'originalText': '', 'translatedText': ''},
  );

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(item['translatedText'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${item['originalText']} - ${item['date']}'),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavigationBar(),
      body: Stack(
        children: [
           Background(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: translationHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildHistoryCard(translationHistory[index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
