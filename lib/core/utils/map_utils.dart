import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static Future<void> openMap(double latitude, double longitude) async {
    final Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      final Uri appleUrl = Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');
      if (await canLaunchUrl(appleUrl)) {
        await launchUrl(appleUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}
