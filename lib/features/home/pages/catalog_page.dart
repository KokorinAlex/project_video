import 'package:project_video/app/constants.dart';
import 'package:project_video/app/delayed_action.dart';
import 'package:project_video/app/models/home_model.dart';
import 'package:project_video/app/widgets/film_card.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/features/settings/pages/setting_page.dart';
import "dart:math";
import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings',
                arguments: const SettingsArguments('BOBIK'),
              );
            },
          ),
        ],
      ),
      body: const FilmGrid(),
    );
  }
}

class FilmGrid extends StatefulWidget {
  const FilmGrid({Key? key}) : super(key: key);

  @override
  State<FilmGrid> createState() => _FilmGridState();
}

class _FilmGridState extends State<FilmGrid> {
  Future<HomeModel?>? dataLoadingState;
  final TextEditingController textController = TextEditingController();

  @override
  void didChangeDependencies() {
    dataLoadingState ??=
        FilmsRepository.loadData(context, q: MovieQuery.initialQ);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: TextField(
            controller: textController,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: MovieLocal.search,
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: _onSearchFieldTextChanged,
          ),
        ),
        FutureBuilder<HomeModel?>(
          future: dataLoadingState,
          builder: (BuildContext context, AsyncSnapshot<HomeModel?> data) {
            return data.connectionState != ConnectionState.done
                ? const Center(child: CircularProgressIndicator())
                : data.hasData
                    ? data.data?.results?.isNotEmpty == true
                        ? Expanded(
                            child: GridView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: FilmCard.fromModel(
                                    model: data.data!.results![index],
                                  ),
                                );
                              },
                              itemCount: data.data?.results?.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                              ),
                            ),
                          )
                        : const _Empty()
                    : const _Error();
          },
        ),
      ]),
    );
  }

  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      dataLoadingState = FilmsRepository.loadData(
        context,
        q: text.isNotEmpty ? text : MovieQuery.initialQ,
      );
      setState(() {});
    });
  }

  Future<void> _pullToRefresh() async {
    List refresh = [
      'bad',
      'girl',
      'throne',
      'game',
      'father',
      'family',
      'sister'
    ];
    var i = refresh[Random().nextInt(refresh.length)];
    dataLoadingState = FilmsRepository.loadData(
      context,
      q: '$i',
    );
    setState(() {});
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.pisecImageUrl,
      fit: BoxFit.fitWidth,
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.nothingImageUrl,
      fit: BoxFit.cover,
    );
  }
}




// @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemBuilder: (BuildContext context, int index) {
//         return Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: FilmCard.fromModel(model: films[index % films.length]));
//       },
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 2 / 3,
//       ),
//     );
//   }
// }