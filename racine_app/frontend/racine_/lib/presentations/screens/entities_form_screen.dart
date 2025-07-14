import 'package:flutter/material.dart';

void main() => runApp(FormulaireApp());

class FormulaireApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: EntiteFormPage());
  }
}

class EntiteFormPage extends StatefulWidget {
  @override
  _EntiteFormPageState createState() => _EntiteFormPageState();
}

class _EntiteFormPageState extends State<EntiteFormPage> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulaire d'entité")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Choisissez une entité"),
              value: selectedType,
              items: [
                'Personne',
                'Entreprise',
                'Association/Équipe',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedType = val),
            ),
            SizedBox(height: 20),
            if (selectedType == 'Personne') PersonneForm(),
            if (selectedType == 'Entreprise') EntrepriseForm(),
            if (selectedType == 'Association/Équipe') AssociationForm(),
          ],
        ),
      ),
    );
  }
}

class PersonneForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informations personnelles",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(decoration: InputDecoration(labelText: 'Nom complet')),
        TextFormField(
          decoration: InputDecoration(labelText: 'Date de naissance'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Lieu de naissance'),
        ),
        TextFormField(decoration: InputDecoration(labelText: 'Nationalité')),
        TextFormField(
          decoration: InputDecoration(labelText: 'Adresse de résidence'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Situation familiale'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Numéro d\'identité'),
        ),
        TextFormField(decoration: InputDecoration(labelText: 'Email')),
        TextFormField(decoration: InputDecoration(labelText: 'Téléphone')),
        SizedBox(height: 20),
        Text("Éducation & Profession"),
        TextFormField(decoration: InputDecoration(labelText: 'Diplômes')),
        TextFormField(decoration: InputDecoration(labelText: 'Poste actuel')),
        TextFormField(decoration: InputDecoration(labelText: 'Compétences')),
        TextFormField(
          decoration: InputDecoration(labelText: 'Langues parlées'),
        ),
      ],
    );
  }
}

class EntrepriseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informations sur l'entreprise",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Nom de l'entreprise"),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Numéro d\'immatriculation'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Forme juridique'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Date de création'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Adresse du siège'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Secteur d’activité'),
        ),
        TextFormField(decoration: InputDecoration(labelText: 'Site web')),
        TextFormField(decoration: InputDecoration(labelText: 'Effectif')),
        TextFormField(
          decoration: InputDecoration(labelText: 'Chiffre d\'affaires'),
        ),
      ],
    );
  }
}

class AssociationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informations sur l'association / équipe",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nom de l\'association'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Date de création'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Fondateur / Président'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Statut juridique'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Adresse du siège'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Objectifs / missions'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nombre de membres'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Sources de financement'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Site web / réseaux sociaux'),
        ),
      ],
    );
  }
}
