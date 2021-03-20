String GOOGLE_API_KEY = 'AIzaSyCytIICLKx1nuebX_mNF5IC5NiFCwnBkVA';

class LocationHelper {
  static String staticMapImageUrl({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.702147,-74.015794&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
