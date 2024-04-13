import 'package:http/http.dart' as http;

Future Getdata(url) async {
  print('got in the getdata statement with $url');
  http.Response Response = await http.get(Uri.parse(url));
  return Response.body;
}