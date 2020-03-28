import 'package:flutter/material.dart';
import 'package:depotoir_test/modele/item.dart';
import 'package:depotoir_test/widgets/donnée_vide.dart';
import 'package:depotoir_test/modele/bd_utilisateur.dart';
import 'package:depotoir_test/widgets/detail.dart';


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  String nouvelleListe;
  List<Item> items;

  @override
  void initState() {
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('list'),
        leading: new Icon(Icons.list),
        elevation: 10.0,
        centerTitle: true,
         
      ),
      body: (items == null ||items.length == 0)
          ? new DonneesVide()
          : new ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              Item item = items[i];
              return new ListTile(
                title: new Text(item.nom),
                trailing: new IconButton(
                  icon: new Icon(Icons.delete), 
                  onPressed: () {
                    DatabaseClient().delete(item.id, 'item').then((int) {
                      recuperer();
                    });
                  }),
                leading: new IconButton(icon: new Icon(Icons.edit), onPressed: (() => ajouter(item))),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                      return new ItemDetail(item);
                  }));
                },
              );
            }
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,  
      floatingActionButton: FloatingActionButton(
        onPressed: (() =>ajouter(null)), 
        child: new Icon(Icons.add),
        ),    
    );
  }

  Future<Null> ajouter(Item item) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: new Text('Enregistrer un nouveau lieux'),
          content: new TextField(
            decoration: new InputDecoration(
              labelText: "Nom du lieu",
              hintText: (item == null)?"ex: resto 'Le Coin'": item.nom,
            ),
            onChanged: (String str) {
              nouvelleListe = str;
            },
          ),
          actions: <Widget>[
            new FlatButton(onPressed: (() => Navigator.pop(buildContext)), child: new Text('Annuler')),
            new FlatButton(onPressed: () {
              // ajouter le code ici pour l base de donnée
              if (nouvelleListe != null) {
                if (item == null) {
                  item = new Item();
                  Map<String, dynamic> map = {'nom': nouvelleListe};
                  item.fromMap(map);
                } else {
                  item.nom = nouvelleListe;
                }
                DatabaseClient().upsertItem(item).then((i) => recuperer());
                nouvelleListe = null;
              }
              Navigator.pop(buildContext);
            }, child: new Text('valider', style: new TextStyle(color: Colors.blue),))
          ],
        );
      }
      );
  }

  void recuperer() {
    DatabaseClient().allItem().then((items) {
      setState(() {
        this.items = items;
      });
    });
  }

  
}