import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/screens/data_entry_form.dart';
import 'package:ma_solutions_cms/utils/constants.dart';
class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  State<DataEntryScreen> createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry'),
      ),
      
      body: Padding(
        padding: EdgeInsets.all(defaultSpace * 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Data Entry Form',
                style: Theme.of(context).
                textTheme.headlineMedium?.copyWith(
                    color: primaryColor),
              ),

              const SizedBox(height: 30.0,),

              const DataEntryForm(),


            ],
          ),
        ),
      ),
    );
  }
}
