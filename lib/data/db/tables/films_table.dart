import 'package:drift/drift.dart';

class FilmsTable extends Table {
  @override
  Set<Column<dynamic>> get primaryKey => <IntColumn>{id};

  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get picture => text().nullable()();
  RealColumn get voteAverage => real().nullable()();
  TextColumn get releaseDate => text().nullable()();
  TextColumn get description => text().nullable()();
}
