import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmit/Database/databasedata.dart';

class OrderDetails extends StatefulWidget {
  final String? id;
  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int active = 1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: const Text('Order Details', style: TextStyle(color: Colors.black, fontSize: 23)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder(
            stream: FirebaseData.getpendngOrder(widget.id!),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black54),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];
                _updateActiveStep(data);

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderInfoRow('Order Id :', widget.id!),
                      const SizedBox(height: 5),
                      _buildOrderInfoRow('Date :', data['Date']),
                      const SizedBox(height: 20),
                      _buildReceiverCustomerInfo(data),
                      const SizedBox(height: 20),
                      _buildAddressInfo('Receiver Address :', data['R_address']),
                      const SizedBox(height: 15),
                      _buildOrderInfoRow('Total Amount :', "\u{20B9} ${data['Total Amount']}"),
                      const SizedBox(height: 5),
                      _buildPaymentMethod(data),
                      const SizedBox(height: 10),
                      _buildStepper(),
                      const SizedBox(height: 10),
                      Divider(color: Colors.black45),
                      const SizedBox(height: 20),
                      const Text('Product Details :', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
                      const SizedBox(height: 10),
                      _buildProductDetails(data),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _updateActiveStep(DocumentSnapshot data) {
    if (data["order_placed"] == true) {
      active = 1;
      if (data["Confirmed"] == true) {
        active = 2;
        if (data["Shipped"] == true) {
          active = 3;
          if (data["Delivered"] == true) {
            active = 4;
          }
        }
      }
    }
  }

  Widget _buildOrderInfoRow(String title, String value) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(width: 10),
        Text(value, style: const TextStyle(fontSize: 20)),
      ],
    );
  }

  Widget _buildReceiverCustomerInfo(DocumentSnapshot data) {
    return Row(
      children: [
        _buildInfoColumn('Reciever Name :', data['R_name'], 'Receiver Contact :', data['R_contact']),
        const SizedBox(width: 4),
        _buildInfoColumn('Customer UID :', data['C_uid'], 'Customer Contact :', data['C_contact']),
      ],
    );
  }

  Widget _buildInfoColumn(String title1, String value1, String title2, String value2) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
          Text(value1, style: const TextStyle(fontSize: 18, color: Colors.orange)),
          const SizedBox(height: 10),
          Text(title2, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
          Text(value2, style: const TextStyle(fontSize: 18, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildAddressInfo(String title, String value) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 18, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(DocumentSnapshot data) {
    return Row(
      children: [
        const Text('Payment Method :', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(width: 10),
        Text(data['COD'] == true ? "Cash On delivery" : "Online", style: const TextStyle(fontSize: 20)),
      ],
    );
  }

  Widget _buildStepper() {
    return EasyStepper(
      lineType: LineType.normal,
      activeStep: active,
      direction: Axis.horizontal,
      lineColor: Colors.black,
      stepRadius: 20,
      unreachedStepIconColor: Colors.black,
      unreachedStepBorderColor: Colors.amberAccent,
      finishedStepBackgroundColor: Colors.black,
      unreachedStepBackgroundColor: Colors.amberAccent,
      onStepReached: (index) => setState(() => active = index),
      steps: const [
        EasyStep(icon: Icon(Icons.add_task_rounded), activeIcon: Icon(Icons.add_task_rounded), title: 'Order Placed'),
        EasyStep(icon: Icon(Icons.confirmation_num_outlined), activeIcon: Icon(Icons.filter_center_focus_sharp), title: 'Confirmed'),
        EasyStep(icon: Icon(Icons.local_shipping_outlined), activeIcon: Icon(Icons.local_shipping_outlined), title: 'Shipping'),
        EasyStep(icon: Icon(Icons.check_circle_outline), activeIcon: Icon(Icons.check_circle_outline), title: 'Delivered'),
      ],
    );
  }

  Widget _buildProductDetails(DocumentSnapshot data) {
    return Column(
      children: List.generate(
        data["Order"].length,
        (index) => Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Image.network(data["Order"][index]['image'], width: 100, height: 100),
                const SizedBox(width: 3),
                _buildProductInfo(data, index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(DocumentSnapshot data, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data["Order"][index]['name'], maxLines: 2, style: GoogleFonts.akshar(fontSize: 20, color: Colors.black)),
            const SizedBox(height: 5),
            Row(
              children: [
                Text("\u{20B9} ${data["Order"][index]['price']}", style: GoogleFonts.bebasNeue(fontSize: 24, color: Colors.black54)),
                const Spacer(),
                Text("Qty : ${data["Order"][index]['qty']}", style: GoogleFonts.bebasNeue(fontSize: 24, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
