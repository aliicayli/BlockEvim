import 'package:blockevim/life_meaning_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lifeMeaningProvider = Provider.of<LifeMeaningProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Blockchain Messages"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<LifeMeaningProvider>(
              builder: (context, lifeMeaningModel, child) {
                return lifeMeaningModel.loading
                    ? CircularProgressIndicator()
                    : Text(
                  lifeMeaningModel.lifeMeaning.toString(),
                  style: TextStyle(fontSize: 20.0),
                );
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    String message = _messageController.text;
                    try {
                      await lifeMeaningProvider.setText(BigInt.from(int.parse(message)));
                    } catch (e) {
                      print("HATA ÇİKTİİİİİ _____ >> ${e}");
                    }
                    _messageController.clear();
                  },
                  child: Text('Send Message'),
                ),
                ElevatedButton(
                  onPressed: () {
                    lifeMeaningProvider.getText();
                  },
                  child: Text('Get Message'),
                ),
              ],
            ),

            SizedBox(height: 50.0),
            
            Image.network("https://seeklogo.com/images/R/rent-house-logo-0E77E0B068-seeklogo.com.png")
          ],
        ),
      ),
    );
  }
}
