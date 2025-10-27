import 'package:flutter/material.dart';
import 'package:page_creators/pages/project_intent.dart';
import 'package:page_creators/pages/statistics_section.dart';
import '../db/propriedades_dao.dart';
import '../domain/propriedade.dart';
import '../domain/cancer_article.dart';
import '../services/news_api_service.dart';
import 'creators_section.dart';
import 'news_section.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late Future<List<Propriedade>> futurePropriedades;
  late Future<List<CancerArticle>> futureNews;
  late Future<Map<String, CancerArticle>> futureCancerEstimates;

  @override
  void initState() {
    super.initState();
    futurePropriedades = PropriedadesDao().listarPropriedades();
    futureNews = NewsApiService().fetchCancerNews();
    futureCancerEstimates = NewsApiService().fetchLungCancerEstimates();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: const Text(
            'SOBRE O PROJETO',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFFC49CE8),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Seções do AboutUsPage
            CreatorsSection(futurePropriedades: futurePropriedades),
            const SizedBox(height: 24),
            NewsSection(futureNews: futureNews),
            const SizedBox(height: 24),
            StatisticsSection(futureCancerEstimates: futureCancerEstimates),
            const SizedBox(height: 24),
            const ProjectIntentSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}