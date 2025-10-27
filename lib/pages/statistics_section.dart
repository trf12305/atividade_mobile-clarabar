import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_creators/domain/cancer_article.dart';
import 'package:page_creators/services/news_api_service.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key, required Future<Map<String, dynamic>> futureCancerEstimates});

  Future<Map<String, CancerArticle>> fetchEstimates() async {
    return NewsApiService().fetchLungCancerEstimates();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, CancerArticle>>(
      future: fetchEstimates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text(
            'Não foi possível carregar os dados.\n${snapshot.error}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          );
        } else if (snapshot.hasData) {
          final estimates = snapshot.data!;
          final male = estimates['homens']!;
          final female = estimates['mulheres']!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'ESTIMATIVA DE NOVOS CASOS DE CÂNCER DE PULMÃO NO BRASIL',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Homens', male.newCases),
                        _buildStatItem('Mulheres', female.newCases),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fonte: Observatório de Oncologia (Dados de 2023)',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildStatItem(String title, int value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
