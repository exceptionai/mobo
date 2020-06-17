import 'package:flutter/material.dart';
import 'package:mobo/components/insert_roommate.dart';
import 'package:mobo/models/roommate_model.dart';
import 'package:mobo/repository/roommate_repository.dart';

class RoommateScreen extends StatefulWidget {
  @override
  _RoommateScreenState createState() => _RoommateScreenState();
}

class _RoommateScreenState extends State<RoommateScreen> {

  void _saveRoommate (String text) async{
    print("teste");
    print(text);
    RoommateModel model = RoommateModel();
    model.name = text;
    model = await RoommateRepository().saveRoommate(model);
    setState(() {});
  }

  Widget _buildCard(RoommateModel model,int index){
    
    return Container(
      width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: 20.0, 
          bottom: 8.0,
          left: 40.0,
          right: 40.0
        ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
        
         ),
        ),
      child:Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left:20),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(model.name,
              style:TextStyle(
                color: Colors.blueGrey[400],
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: IconButton(
              icon:Icon(Icons.delete_outline),
              iconSize: 40.0,
              color:Theme.of(context).primaryColor,
              onPressed: (){
                RoommateRepository().deleteRoommate(model.id);
                setState(() {
                  
                });
              },
            ),
          ),
        ],
      ),
    ); 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,//Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          iconSize: 30.0,
          onPressed:(){
            Navigator.of(context).pushNamed('/');
          }, 
        ),
        title: Text(
          'Amigos',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[400],
          ),
        ),
        elevation: 0.0,
        backgroundColor:Colors.white70,
      ),
      body:GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                     gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xffc1fcd3),Color(0xff0ccda3) ]
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: FutureBuilder<List<RoommateModel>>(
                      future: RoommateRepository().getAllRoommatees(),
                      builder: (BuildContext context, AsyncSnapshot<List<RoommateModel>> snapshot){
                        if(snapshot.hasData){
                          return ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 15.0),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index){
                                  RoommateModel messageModel = snapshot.data[index];
                                  return _buildCard(messageModel,index);
                                },
                            ),
                          );
                        }else {
                          return Center (child: CircularProgressIndicator());
                        }
                      },
                    ),
              ),
            ),
          InsertRoommate(_saveRoommate),
          ],
        ),
      ),
    );
  }
}