import 'package:flutter_taxi_user/datamodel/datatypes.dart';

// ignore: non_constant_identifier_names
String triphistorydata_string = '''[{
      "latitude": 0,
      "longitude": 0,
      "km": 0,
      "baseKm": 0,
      "radius": null,
      "source": null,
      "destination": null,
      "olddestination": null,
      "desc": "string",
      "type": null,
      "tax": 0,
      "localKm": 0,
      "percentage": 0,
      "userId": null,
      "driverId": null,
      "createdBy": null,
      "status": null,
      "supplierId": null,
      "price": 0,
      "totalPrice": 0,
      "totalTravelTimePrice": 0,
      "userTotalPrice": 0,
      "basePrice": 0,
      "travelTime": 0,
      "totalwaitTime": 0,
      "startDate": null,
      "endDate": null,
      "estimateTime": 0,
      "debit": 0,
      "payment": null,
      "discount": null,
      "discountPrice": 0,
      "category": null,
      "ids": null,
      "updatedOn": null
    },
    {
      "latitude": 0,
      "longitude": 0,
      "km": 0,
      "baseKm": 0,
      "radius": null,
      "source": null,
      "destination": null,
      "olddestination": null,
      "desc": "GSDSDSD",
      "type": null,
      "tax": 0,
      "localKm": 0,
      "percentage": 0,
      "userId": null,
      "driverId": null,
      "createdBy": null,
      "status": null,
      "supplierId": null,
      "price": 0,
      "totalPrice": 0,
      "totalTravelTimePrice": 0,
      "userTotalPrice": 0,
      "basePrice": 0,
      "travelTime": 0,
      "totalwaitTime": 0,
      "startDate": null,
      "endDate": null,
      "estimateTime": 0,
      "debit": 0,
      "payment": null,
      "discount": null,
      "discountPrice": 0,
      "category": null,
      "ids": null,
      "updatedOn": null
    }]''';
int triphistorynum = 0;

Triphistoryinfotype triphistorydata = new Triphistoryinfotype();

List<Map<String, dynamic>> listRequest = List<Map<String, dynamic>>();
int requirenum = 0;

//driver data
List<Map<String, dynamic>> cdriverdata = List<Map<String, dynamic>>();
String demotaxidriver = '[{"id": "5fd2613d0cc530017e9f5309"}]';