import 'dart:io';
import 'package:depotoir_test/modele/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'article.dart';


class DatabaseClient {
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }else {
      _database = await create();
      return _database;
    }
  }


  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = join(directory.path, 'database.db');
    var dbb = await openDatabase(database_directory, version: 1, onCreate: _onCreate);
    return dbb;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
    'CREATE TABLE item ( id INTEGER PRIMARY KEY, nom TEXT NOT NULL)');

    await db.execute(
      'CREATE TABLE article ( id INTEGER PRIMARY KEY, nom TEXT NOT NULL, item INTEGER, descrition TEXT, image TEXT)'
    );
  }


  /* ECRITURE DES DONNEE*/

  Future<Item> ajoutItem(Item item) async {
    Database maDatabase = await database;
    item.id = await maDatabase.insert('item', item.toMap());
    return item;

  }

  Future<int> updateItem(Item item) async {
    Database maDatabase = await database;
    return await maDatabase.update('item', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> upsertItem(Item item) async {
    Database maDatabase = await database;
    if (item.id == null) {
      item.id = await maDatabase.insert('item', item.toMap());
    }else {
      await maDatabase.update('item', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
    }
  }
  
  Future<Article> upsertArticle(Article article) async {
    Database maDatabase = await database;
    (article.id == null)
      ? article.id = await maDatabase.insert('article', article.toMap())
      : await maDatabase.update('article', article.toMap(), where: 'id = ?', whereArgs: [article.id]);
    return article;  
  }

  Future<int> delete(int id, String table) async {
    Database maDatabase = await database;
    await maDatabase.delete('article', where: 'item = ?', whereArgs: [id]);
    return await maDatabase.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  /* LECTURE DE DONNEE*/

  Future<List<Item>> allItem() async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery('SELECT * FROM item');
    List<Item> items = [];
    resultat.forEach((map) {
      Item item = new Item();
      item.fromMap(map);
      items.add(item);
    });
    return items;
  }

  Future<List<Article>> allArticle(int item) async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> resultat = await maDatabase.query('article', where: 'item = ?', whereArgs: [item]);
    List<Article> articles =[];
    resultat.forEach((map) {
      Article article = new Article();
      article.fromMap(map);
      articles.add(article);
    });
    return articles;
  }

}