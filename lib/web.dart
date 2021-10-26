import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert'; //

Future<int> getPawnedData(password) async {
  String sha1password = getSha1password(password);

  try {
    var url = Uri.parse(
        'https://api.pwnedpasswords.com/range/${sha1password.substring(0, 5)}');
    var res = await http.get(url);
    return findmatch(sha1password, res.body.split('\n'));
  } catch (error) {
    return -1;
  }
}

String getSha1password(password) {
  var binpass = utf8.encode(password);
  var shapass = sha1.convert(binpass);
  return shapass.toString().toUpperCase();
}

int findmatch(String sha1password, List<String> pawnwedpasswords) {
  var count = 0;
  for (var element in pawnwedpasswords) {
    var item = element.split(':');

    if (sha1password.substring(5) == item[0]) {
      count = int.parse(item[1]);
    }
  }

  return count;
}
