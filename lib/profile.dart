import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
   
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: GestureDetector(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              Text("My Account",style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: 20,),
              Text("9025610366"),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                   color: Color(0xFFF5F5DC),),
                 
                  width: width*0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      
                      children: [
                        col(Icons.wallet,"Wallets"),
                        col(Icons.wallet,"Wallets"),
                        col(Icons.wallet,"Wallets"),
                        
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h,),
              Text('YOUR INFORMATION',textAlign: TextAlign.left,style: Theme.of(context).textTheme.displaySmall),
              SizedBox(height: 15,),
              lt(Icons.receipt,"Your Orders"),
              SizedBox(height: 15,),
              lt(Icons.receipt,"Bookmarked Recipes"),
              SizedBox(height: 15,),
              lt(Icons.receipt,"Address Book"),
              SizedBox(height: 15,),
              lt(Icons.receipt,"GST Details"),
              SizedBox(height: 15,),
              lt(Icons.receipt,"E-Gift Cards"),
              SizedBox(height: 15,),
               SizedBox(height: 40.h,),
              Text('PAYMENTS AND COUPONS',textAlign: TextAlign.left,style: Theme.of(context).textTheme.displaySmall),
              SizedBox(height: 15,),
              lt(Icons.receipt,"Wallet"),
              SizedBox(height: 15,),
              lt(Icons.receipt,"Payment Settings"),
              SizedBox(height: 15,),
              lt(Icons.receipt,"Collected Coupons"),
              SizedBox(height: 15,),
              
          
          
            ],
          ),
        ),
      ),
    );
  }

  ListTile lt(icons,name) {
    return ListTile(title: Text(name,style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.black),),leading: CircleAvatar(child: Icon(icons),),
          trailing:Text(">",style: Theme.of(context).textTheme.displaySmall));
  }

  Material col(icons,name) {
    return Material(
      color: Color(0xFFF5F5DC),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: (){},
        splashColor: Colors.grey,
        child: Column(
                      children: [
                        Icon(icons,size: 40,),
                        Text(name)
                      ],
                  ),
      ),
    );
  }
}