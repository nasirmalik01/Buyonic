// import 'package:buyonic/model/shipment.dart';
// import 'package:flutter/material.dart';
//
// Widget shipmentWidget({int snapshotLength, }){
//   return ListView.builder(
//   scrollDirection: Axis.vertical,
// itemCount: snapshotLength,
// itemBuilder: (context, index) {
// List<Shipment> shipment = [];
// List<dynamic> productsInfoList =
// snapshotData[index].get('ProductsInfo');
// productsInfoList.forEach((data) {
// shipment.add(Shipment(
// productName: data['productName'],
// price: data['Price'],
// quantity: data['Quantity'],
// ));
// });
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// elevation: 5,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// ListView.builder(
//
// shrinkWrap: true,
// itemCount: shipment.length,
// itemBuilder: (context, index){
// return Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Container(
// height: 100,
// child: Image(
// image: NetworkImage(
// 'https://www.gizmochina.com/wp-content/uploads/2019/03/Lenovo-ideapad-720S-Notebook-600x600.jpg'
// ),
// ),
// ),
// Column(
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 4.0),
// child: FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText(title: '${shipment[index].productName}')),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 4.0),
// child: FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText5(title:  'Quantity: ${shipment[index].quantity.toString()}')),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 4.0),
// child: FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText3(title: 'PKR: ${shipment[index].price}')),
// ),
// ],
// ),
// ],
// ),
// ],
// );
// }),
// Divider(color: Colors.grey, indent: 20, endIndent: 20,),
// Padding(
// padding: const EdgeInsets.only(top: 4.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText6(title: 'Total Payment: ')),
// FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText6(title: 'PKR: ${snapshotData[index].get('TotalPayment')}')),
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText6(title: 'Status: ')),
// FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText6(title: '${snapshotData[index].get('status')}')),
// ],
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// );
//
//   });
// }


import 'package:flutter/material.dart';

Widget imageShipment({BuildContext context, String imageUrl}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.25,
      child: GridTile(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/placeholder.jpg'),
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
