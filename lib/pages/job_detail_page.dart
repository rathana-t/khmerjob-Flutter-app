import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:khmerjob_project/models/job_model.dart';
import 'package:khmerjob_project/pages/home_page.dart';
import 'package:khmerjob_project/pages/profile_page.dart';
import 'package:khmerjob_project/repo/job_repo.dart';

class JobDetailPage extends StatefulWidget {
  String id;

  JobDetailPage(this.id);

  // JobDetailPage(JobElement id);

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  double _widthOfScreen;
  Future<Job> _jobData;

  @override
  void initState() {
    super.initState();
    _jobData = getJobDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
      bottomNavigationBar: _buildBottomBar,
    );
  }

  get _buildAppBar {
    return AppBar(
      // iconTheme: IconThemeData(
      //   color: Colors.black, //change your color here
      // ),
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Colors.white70,
      title: Container(
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Image.asset(
            'assets/images/LogoKhmerjob.png',
            fit: BoxFit.cover,
            height: 22,
            width: 157,
          ),
        ),
      ),
      actions: [
        _buildProfile,
        _buildPostJob,
      ],
    );
  }

  get _buildProfile {
    return IconButton(
        icon: Image.asset('assets/images/profile.png'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfilePage()));
        });
  }

  get _buildPostJob {
    return InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ));
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 6, bottom: 6, right: 15, left: 15),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            "PostJob",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.lightBlue),
        ));
  }

  get _buildBody {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _buildJobFutureAPI,
      ],
    );
  }

  get _buildJobFutureAPI {
    return Container(
      child: FutureBuilder<Job>(
        future: _jobData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            return _buildJobs(snapshot.data.jobs);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _buildJobs(List<JobElement> itemList) {
    return Container(
      alignment: Alignment.center,
      // color: Colors.lightBlueAccent,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          // Container(
          //   height: 50,
          //   margin: EdgeInsets.only(top: 5, bottom: 15),
          //   alignment: Alignment.center,
          //   child: Text(
          //     'Job in category',
          //     style: TextStyle(fontSize: 20,color: Colors.white),
          //   ),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: Colors.blue,
          //   ),
          // ),
          Container(
            width: _widthOfScreen,
            child: ListView.builder(
              // GridView.builder
              physics: NeverScrollableScrollPhysics(),
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 1,
              // mainAxisSpacing: 10,
              // crossAxisSpacing: 10,
              // ),
              itemCount: itemList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItemJob(itemList[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

// img, title, catogory, location, type, salary
  _buildItemJob(JobElement item, index) {
    // return InkWell(
    //   onTap: () {
    //     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> JobDetailPage() ));
    //   },
    return Container(
      // color: index.isEven ? Colors.lightBlueAccent.withOpacity(0.1) : Colors.white54.withOpacity(0.1),
      //   color: Colors.,
      // width: 150,  useless
      child: Column(
        children: [
          Container(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.all(2),
                  width: 150,
                  height: 130,
                  margin: EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/images/jobs/' + item.image,
                    fit: BoxFit.cover,
                  ),
                  // child: Image.asset('assets/images/jobs/jobImage/' + item.image),
                ),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.yellowAccent,
                          margin: EdgeInsets.only(bottom: 5),
                          alignment: Alignment.topLeft,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            // strutStyle: StrutStyle(fontSize:12.0),
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                              ),
                              text: item.title,
                            ),
                          ),
                          // decoration: BoxDecoration(
                          // border:Bor
                          // color: Colors.blue,

                          // ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.home_work,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    // strutStyle: StrutStyle(fontSize:12.0),
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      text: item.name,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    // strutStyle: StrutStyle(fontSize:12.0),
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      text: item.location,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  // strutStyle: StrutStyle(fontSize:12.0),
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    text: item.createdAt
                                        .toString()
                                        .substring(0, 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // width: 100,
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 6, bottom: 6),
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 100,
                            // strutStyle: StrutStyle(fontSize:12.0),
                            child: Text(
                              "\$ " + item.salary,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "DETAIL JOB",
                    style: TextStyle(
                        color: Colors.red, fontSize: 20, letterSpacing: 2),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Job Type : ",
                          style: TextStyle(color: Colors.indigo, fontSize: 18),
                        ),
                        Text(
                          item.typeJob.toString().substring(8),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "Experience : ",
                          style: TextStyle(color: Colors.indigo, fontSize: 18),
                        ),
                        Text(
                          item.experience.toString().substring(15) + " +",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Salary Start From : \$",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.salary,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "JOB DESCRIPTION",
                    style: TextStyle(
                        color: Colors.red, fontSize: 20, letterSpacing: 2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "ABOUT COMPANY",
                    style: TextStyle(
                        color: Colors.red, fontSize: 20, letterSpacing: 2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Name : ",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Phone : ",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.phone.toString().substring(10),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Email : ",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.email,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Address : ",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.address.toString().substring(8),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Location : ",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.location,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        "Website : ",
                        style: TextStyle(color: Colors.indigo, fontSize: 18),
                      ),
                      Text(
                        item.website,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  get _buildBottomBar{
    return Container(
      height: 55,
      margin: EdgeInsets.all(5),
      // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.favorite_border, color: Colors.white), Text("SAVE", style: TextStyle(color: Colors.white))],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text("APPLY NOW", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white ,fontSize: 18)),

            ),
          ),
        ],
      ),

    );
  }
}
