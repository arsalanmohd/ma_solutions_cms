import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/dashboard_model.dart';
import 'package:ma_solutions_cms/utils/constants.dart';

class DataEntryForm extends StatelessWidget {
  const DataEntryForm({super.key});

  static var _paymentStatus = ['Paid', 'Due'];

  static var _receiveStatus = ['Received', 'NotReceived'];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Name and Product Name
          Row(
            children: [
              Expanded(child: TextFormField(
                expands: false,
                decoration: InputDecoration(labelText: 'Customer Name', prefixIcon: const Icon(Icons.person)),
              ),),
              const SizedBox(width: defaultSpace * 2),
              Expanded(child: TextFormField(
                decoration: InputDecoration(labelText: 'Product Name', prefixIcon: const Icon(CupertinoIcons.collections)),
              ),),
            ],
          ),

          const SizedBox(height: defaultSpace * 2),

          /// Number and Occupation
          Row(
            children: [
              Expanded(child: TextFormField(
                expands: false,
                decoration: InputDecoration(labelText: 'Customer Number', prefixIcon: const Icon(Icons.phone)),
              ),),
              const SizedBox(width: defaultSpace * 2),
              Expanded(child: TextFormField(
                decoration: InputDecoration(labelText: 'Occupation', prefixIcon: const Icon(CupertinoIcons.bag)),
              ),),
            ],
          ),

          const SizedBox(height: defaultSpace * 2),

          /// Date and Amount
          Row(
            children: [
              Expanded(child: TextFormField(
                expands: false,
                decoration: InputDecoration(labelText: 'Date', prefixIcon: const Icon(Icons.calendar_today)),
              ),),
              const SizedBox(width: defaultSpace * 2),
              Expanded(child: TextFormField(
                decoration: InputDecoration(labelText: 'Amount', prefixIcon: const Icon(Icons.currency_rupee_rounded)),
              ),),
            ],
          ),

          SizedBox(height: defaultSpace * 2,),

          /// Create Account
          SizedBox(width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
            ),
          ),
          const SizedBox(height: defaultSpace),


        ],
      ),
    );
  }
}
