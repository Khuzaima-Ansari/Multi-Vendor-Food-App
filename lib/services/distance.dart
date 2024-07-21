import 'dart:math';

import 'package:foodly/models/distance_time.dart';

class Distance {
  DistanceTime calculateDistanceTimePrice(double lat1, double lon1, double lat2,
      double lon2, double speedKmPerHr, double priceKmHr) {
    double lat1Rad = degreesToRadians(lat1);
    double lon1Rad = degreesToRadians(lon1);
    double lat2Rad = degreesToRadians(lat2);
    double lon2Rad = degreesToRadians(lon2);

    // Haversine Formula
    var dLat = lat2Rad - lat1Rad;
    var dLon = lon2Rad - lon1Rad;
    var a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Radius of the earth in kms
    const double earthRadiusKm = 6371.0;
    var distance = (earthRadiusKm * 2) * c;

    //Calculate time (distance / speed)
    var time = distance / speedKmPerHr;

    // Calculate price (distance * rate per km)
    var price = distance * priceKmHr;

    return DistanceTime(price: price, distance: distance, time: time);
  }

  // Helper function to convert degree to radians
  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
