import 'package:flutter/material.dart';
import 'package:project_video/logic.dart';

void main(List<String> args) => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans-Bold',
              //fontWeight: FontWeight.bold,
              fontSize: 28),
        ),
      ),
      home: const FilmsApp(),
    );
  }
}

class FilmsApp extends StatefulWidget {
  const FilmsApp({Key? key}) : super(key: key);

  @override
  State<FilmsApp> createState() => _FilmsAppState();
}

class _FilmsAppState extends State<FilmsApp> {
  List<NewFilm> films = [];

  bool filterRating = false;

  @override
  void initState() {
    returnList().then((value) {
      setState(() {
        films = value;
      });
    });
    super.initState();
  }

  Icon customIcon = const Icon(
    Icons.search,
    size: 28,
  );
  Widget customSearchBar = const Text('Films');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: customSearchBar,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                      trailing: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {},
                      ),
                      leading: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: const TextField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Enter the name of film',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Films');
                  }
                });
              },
              icon: customIcon)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                    value: filterRating,
                    onChanged: (bool? changeValue) {
                      setState(() {
                        filterRating = changeValue ?? false;
                      });
                    }),
                const Text('Только популярные')
              ],
            ),
            ElevatedButton(
              onPressed: filtration,
              child: const Text('Поиск'),
            ),
            ...List.generate(films.length, (index) {
              return FilmCard(
                  title: films[index].title,
                  picture: films[index].picture,
                  language: films[index]
                      .changeLanguage(films[index].language)
                      .toPrettyString(),
                  id: films[index].id,
                  voteAverage: films[index].voteAverage,
                  releaseDate: films[index].releaseDate,
                  description: films[index].description);
            })
          ],
        ),
      ),
    );
  }

  Future<void> filtration() async {
    await returnList().then((valueFilter) {
      setState(() {
        if (filterRating) {
          films = valueFilter
              .where((element) => element.voteAverage > 8.3)
              .toList();
        } else {
          films = valueFilter;
        }
      });
    });
  }
}

class FilmCard extends StatelessWidget {
  const FilmCard(
      {Key? key,
      required this.title,
      required this.picture,
      required this.language,
      required this.id,
      required this.voteAverage,
      required this.releaseDate,
      required this.description})
      : super(key: key);

  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color.fromARGB(255, 224, 161, 235),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(picture),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('Язык: $language',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('Рейтинг: $voteAverage',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('Дата выхода: $releaseDate',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text('Описание: $description',
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
