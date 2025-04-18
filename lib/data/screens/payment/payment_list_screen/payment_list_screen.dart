import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/database/payment/payment_db.dart';
import 'package:ma_solutions_cms/data/models/payment/payment_model.dart';
import 'package:ma_solutions_cms/data/screens/payment/payment_entry_screen/payment_entry_screen.dart';
import 'package:ma_solutions_cms/utils/constants.dart';
import 'package:ma_solutions_cms/widgets/search_bar_with_buttons.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  Iterable<TableRow>? paymentList = [];
  Iterable<TableRow>? filteredPaymentList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await _loadPaymentData();

      setState(() {
        paymentList = paymentList?.map((payment) => _buildPaymentRowTile(payment as Payment)).toList();
      });

    });
  }

  Future<void> _loadPaymentData() async{
    List<Payment> paymentEntries = (await PaymentDB.getAllPayments());
    setState(() {
      paymentList = paymentList?.map((payment) => _buildPaymentRowTile(payment as Payment)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(defaultSpace),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(defaultSpace / 2),
          ),
          margin: const EdgeInsets.only(
              top: defaultSpace * 2,
              left: defaultSpace,
              right: defaultSpace * 2,
              bottom: defaultSpace * 3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBarWithButtons(
                    onChanged: (searchTerm) {

                    },
                    onTapAdd: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentEntryScreen()),
                      );

                      if (result == true) {
                        await _loadPaymentData(); // Fetch latest data from the database
                      }
                    },
                ),

// -----------------------------------------------------------------------------------------------------------------------------

                SizedBox(height: 20.0,),

                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(100.0),
                  },

                  border: TableBorder(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(0.1), width: 1),
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.1), width: 1),
                      horizontalInside: BorderSide(
                          color: Colors.grey.withOpacity(0.1), width: 1)
                  ),
                  children: [
                    _buildPaymentHeader(),
                    ...?paymentList,
                  ],
                ),


              ],
            ),
          ),
        ))
      ],
    );
  }

  TableRow _buildPaymentRowTile(Payment payment) {
    return TableRow(
      key: ValueKey(payment.id),
      children: [

        _buildPaymentItem(
            child: Text(
              payment.id.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            ),
        ),

        _buildPaymentItem(
            child: Text(
              payment.rentalId.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildPaymentItem(
            child: Text(
                '\₹${payment.amountPaid.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildPaymentItem(
            child: Text(
              payment.paymentDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
              )
        ),

        _buildPaymentItem(
            child: Text(
              payment.paymentMode,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildPaymentItem(
            child: IconButton(onPressed: () {}, icon: Icon(Icons.delete))
        ),

      ]
    );
  }

  TableRow _buildPaymentHeader() {
    return TableRow(
      children: [

        _buildPaymentItem(
            child: Text('id')
        ),

        _buildPaymentItem(
            child: Text('Rental Name')
        ),

        _buildPaymentItem(
            child: Text('Amount Paid')
        ),

        _buildPaymentItem(
            child: Text('Payment Date')
        ),

        _buildPaymentItem(
            child: Text('Payment Mode')
        ),

        _buildPaymentItem(
            child: Container()
        ),


      ]
    );
  }

  TableCell _buildPaymentItem({required Widget child}) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: SizedBox(
          height: 70,
          child: Center(
            child: child,
          ),
        ),
    );
  }

}
