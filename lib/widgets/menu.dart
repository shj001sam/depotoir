import 'package:flutter/material.dart';
import 'package:depotoir_test/modele/item.dart';
import 'package:depotoir_test/widgets/donnée_vide.dart';
import 'package:depotoir_test/modele/bd_utilisateur.dart';


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
              );
            }
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,  
      floatingActionButton: FloatingActionButton(
        onPressed: ajouter, 
        child: new Icon(Icons.add),
        ),    
    );
  }

  Future<Null> ajouter() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return new AlertDialog(
          title: new Text('Enregistrer un nouveau lieux'),
          content: new TextField(
            decoration: new InputDecoration(
              labelText: "Nom du lieu",
              hintText: "ex: resto 'Le Coin'",
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
                Map<String, dynamic> map = {'nom': nouvelleListe};
                Item item = new Item();
                item.fromMap(map);
                DatabaseClient().ajoutItem(item).then((i) => recuperer());
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