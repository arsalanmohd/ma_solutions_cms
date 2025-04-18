import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _backupPath;

  Future<String> getDatabasePath() async {
    final databasesPath = await getDatabasesPath();
    return '$databasesPath/rental_database.db';
  }

  Future<void> backupDatabase() async {
    try {
      String dbPath = await getDatabasePath();
      Directory? directory = await getExternalStorageDirectory();
      String backupPath = '${directory!.path}/rental_backup.db';

      File dbFile = File(dbPath);
      File backupFile = File(backupPath);

      await backupFile.writeAsBytes(await dbFile.readAsBytes());

      setState(() {
        _backupPath = backupPath;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup saved at: $backupPath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backup failed: $e')),
      );
    }
  }

  Future<void> exportDatabase() async {
    if (_backupPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please backup the database first')),
      );
      return;
    }

    final XFile file = XFile(_backupPath!);
    await Share.shareXFiles([file], text: 'Rental Database Backup');
  }

  Future<void> restoreDatabase() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (result != null) {
        String dbPath = await getDatabasePath();
        File selectedFile = File(result.files.single.path!);
        await selectedFile.copy(dbPath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Database restored successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restore failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: backupDatabase,
              child: Text('Backup Data'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: exportDatabase,
              child: Text('Export Data'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: restoreDatabase,
              child: Text('Restore Data'),
            ),
          ],
        ),
      ),
    );
  }
}
