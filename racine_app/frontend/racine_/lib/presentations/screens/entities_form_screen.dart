import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(FormulaireApp());

class FormulaireApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101010),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Colors.white70),
        ),
      ),
      home: EntiteFormPage(),
    );
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
      appBar: AppBar(title: const Text("Création d'entité Racine_")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Type d'entité"),
              value: selectedType,
              items: [
                'Personne',
                'Entreprise',
                'Association/Équipe',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => selectedType = val),
            ),
            const SizedBox(height: 20),
            if (selectedType == 'Personne') PersonneForm(),
            if (selectedType == 'Entreprise') EntrepriseForm(),
            if (selectedType == 'Association/Équipe') AssociationForm(),
          ],
        ),
      ),
    );
  }
}

class UploadSection extends StatelessWidget {
  final String title;
  final String fileType;

  const UploadSection({required this.title, this.fileType = 'file'});

  Future<void> _pickFile() async {
    await FilePicker.platform.pickFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _pickFile,
          icon: const Icon(Icons.upload_file),
          label: const Text('Joindre un fichier'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class PersonneForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Informations personnelles",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nom complet'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Date de naissance'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Lieu de naissance'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nationalité'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Adresse de résidence'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Situation familiale'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Numéro d\'identité'),
        ),
        TextFormField(decoration: const InputDecoration(labelText: 'Email')),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Téléphone'),
        ),
        const SizedBox(height: 20),
        const Text("Éducation & Profession"),
        TextFormField(decoration: const InputDecoration(labelText: 'Diplômes')),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Poste actuel'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Compétences'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Langues parlées'),
        ),
        const UploadSection(
          title: "Pièce d'identité (CNI / Passeport / Autre)",
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
        const Text(
          "Informations sur l'entreprise",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: "Nom de l'entreprise"),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Numéro d\'immatriculation',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Forme juridique'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Date de création'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Adresse du siège'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Secteur d’activité'),
        ),
        TextFormField(decoration: const InputDecoration(labelText: 'Site web')),
        TextFormField(decoration: const InputDecoration(labelText: 'Effectif')),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Chiffre d\'affaires'),
        ),
        const UploadSection(
          title: "Régistre de commerce ou attestation équivalente",
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
        const Text(
          "Informations sur l'association / équipe",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nom de l\'association'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Date de création'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Fondateur / Président'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Statut juridique'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Adresse du siège'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Objectifs / missions'),
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nombre de membres'),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Sources de financement',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Site web / réseaux sociaux',
          ),
        ),
        const UploadSection(
          title: "Statuts signés ou preuve d'enregistrement officiel",
        ),
      ],
    );
  }
}
