import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app_theme.dart';
import '../storage/storage.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String profile_url;


  String practice1="MBBS , DDV(SKIN),DEM(UK)";
  String practice2="FAM(GERMANY),FAD,RMC-31777";

  var search_txt = TextEditingController();

  Map<String,String> treatment_list = {

    'All Skin' : 'images/all_skin.webp' ,
    'Allergies' : 'images/allergies.webp' ,
    'Chemical Peeling' : 'images/chemical_peeling.jpg' ,
    'Triplle Wave Length Diode Laser' : 'images/laser.jpg' ,
    'MICROBLADING , MICROPIGMENT' : 'images/face_lift.webp' ,
    'Hair Transplant' : 'images/hair_transplant.webp' ,
    'IONTOPHORESIS' : 'images/sweating.webp' ,
    'PRP , ACUGEL TREATMENT' : 'images/prp.jpg' ,
    'Psoriasis' : 'images/psoriasis.jpg' ,
    'ND YAG LASER' : 'images/tattoo.jpg' ,
    'MNRF' : 'images/MNRF.jpg' ,
    'BRIDE / GROOM Beauty Treatment Packages' : 'images/bride_groom.webp'

  };

  List<String> search_treatment_list =[];
  List<String> all_treatment_list =[];

  void set_treatment_list(){

   setState(() {
     search_treatment_list = treatment_list.keys.toList();
     all_treatment_list = treatment_list.keys.toList();

   });
  }







  Future future()async{


    await FirebaseFirestore.instance.collection('Dr_Profile').doc('Doctor').get().then((value) {

      profile_url = value['profile_url'];
      practice1 = value['practice1'];
      practice2 = value['practice2'];





    });

  }


  void  onItemChanged(String value) {
    setState(() {
      search_treatment_list = all_treatment_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (search_treatment_list.isEmpty) {
        search_treatment_list = [];
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    future();
    set_treatment_list();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:  EdgeInsets.only(left: 3.w),
        child: Column(
          children: [
            Container(

              alignment: Alignment.centerLeft,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  profile_url==null?CircleAvatar(
                    backgroundColor: AppTheme.grey,
                    radius: 20.w,
                    child: Icon(
                      Icons.person_add_outlined,
                      color: Colors.white,
                    ),


                  ):ClipOval(
                    child: Image.network(
                      profile_url ,
                      height: 40.w,
                      width: 40.w,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircleAvatar(
                            radius: 20.w,
                            backgroundColor: Colors.white70,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),



                  Text(practice1),
                  Text(practice2),

                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 3.h),

              height: 6.h,

              decoration: BoxDecoration(
                  color: AppTheme.notWhite,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(

                controller: search_txt,





                onChanged: onItemChanged,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 7.w , vertical: 1.3.h ),
                    border: InputBorder.none,
                    hintText: 'search',
                    hintStyle:  AppTheme.k_search_text_style
                ),
                keyboardType: TextInputType.name,
              ),
            ),

            SizedBox(

              height: 350,


              child: SingleChildScrollView(

                child: Wrap(

                  runSpacing: 3.w,
                  spacing: 3.w,

                  children: search_treatment_list.map<Widget>((e) {




                    return SizedBox(
                      height: 40.w,
                      width: 40.w,
                      child: Card(
                        color: AppTheme.green,
                        child: Column(
                         children: [
                           Image.asset(treatment_list[e]  ,
                             height: 20.w,
                             width: 20.w,),

                           FittedBox(

                               child: Text(e)),
                         ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
