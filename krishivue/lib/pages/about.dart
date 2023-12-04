import 'dart:io';

import 'package:flutter/material.dart';
import 'package:krishivue/widgets/app_bar.dart';
import "package:http/http.dart" as http;
class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
    final _formKey = GlobalKey<FormState>();
  TextEditingController nController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController kController = TextEditingController();
  TextEditingController rainController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController phController = TextEditingController();
  void _submitdata() async {
     var data={
      'n':nController.text,
      'p':pController.text,
      'k':kController.text,
      'temperature':tempController.text,
      'humidity':humidityController.text,
      'ph':phController.text,
      'rainfall':rainController.text,
      
     };
     print(data);
    //  var apiURL=Uri.parse('your api url');
    //  var request=http.post(
    //   apiURL,
    //   body:data,
      
    //  );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Get a Suitable Crop for Production'),
      body: SafeArea(
        child: Form(
          key: _formKey,
            child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.white
                ),
                
                child: Text("Fill up the form to get best crop",
                style: TextStyle(
                  fontSize: 20,
                 overflow: TextOverflow.clip
                 
                ),
                textAlign:TextAlign.center,
                ),
              ),
            ),
            TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: rainController,
              decoration: InputDecoration(
                labelText: 'Rainfall',
                hintText: "2",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),
         SizedBox(height: 14,),
           TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: nController,
              decoration: InputDecoration(
                labelText: 'Nitrogen',
                hintText: "2",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),

SizedBox(height: 14,),

              TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: pController,
              decoration: InputDecoration(
                labelText: 'Phosphorus',
                hintText: "2",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),

SizedBox(height: 14,),




                TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: kController,
              decoration: InputDecoration(
                labelText: 'Potassium',
                hintText: "2",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),



SizedBox(height: 14,),


                TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: tempController,
              decoration: InputDecoration(
                labelText: 'Temperature',
                hintText: "2 °C",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),




SizedBox(height: 14,),

                TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: humidityController,
              decoration: InputDecoration(
                labelText: 'Humidity',
                hintText: "2",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),
SizedBox(height: 14,),





                TextFormField(
              validator: (value){
                if(value == null||value.isEmpty){
                  return 'Please enter the valid form';
                }
                return null;
              },
              controller: phController,
              decoration: InputDecoration(
                labelText: 'ph',
                hintText: "2",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: Icon(Icons.agriculture),
                suffixIcon: Icon(Icons.delete_outline)
              ),
            ),







            



            
            ElevatedButton.icon(onPressed: (){
              print('${nController.text}');
               // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
        
      );
      _submitdata();
    }
            }, icon: Icon(Icons.post_add), label: Text("Submit"))
          ],
        )),
      ),
    );
  }
}
