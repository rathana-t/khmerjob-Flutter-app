import 'package:flutter/material.dart';
import 'package:khmerjob_project/models/job_model.dart';
import 'package:khmerjob_project/pages/home_page.dart';
import 'package:khmerjob_project/pages/job_detail_page.dart';
import 'package:khmerjob_project/pages/profile_page.dart';
import 'package:khmerjob_project/repo/job_repo.dart';


class BrowseJob extends StatefulWidget {
  String category1;
  BrowseJob(this.category1);

  @override
  _BrowseJobState createState() => _BrowseJobState();
}

class _BrowseJobState extends State<BrowseJob> {
  double _widthOfScreen;
  Future<Job> _jobData;

  // String category1;
  // _BrowseJobState(this.category1);
  // BrowseJob({this.category1});
  // final String gg = category1;

  @override
  void initState() {
    super.initState();
    _jobData = getJobByCategory(widget.category1);
  }

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
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
      title:Container(
        child: InkWell(
          onTap: (){
            Navigator.of(context).pop(MaterialPageRoute(builder:(context)=>HomePage()));
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
        icon: Image.asset('assets/images/profile.png'), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
        });
  }
  get _buildPostJob {
    return InkWell(
        onTap: (){
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
        )
    );
  }

  get _buildBody{
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
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 5, bottom: 15),
            alignment: Alignment.center,
            child: Text(
              'Job in category "' + widget.category1 + '"',
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
            ),
          ),
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
                return _buildItemJob(itemList[index],index);
              },
            ),
          ),
        ],
      ),
    );
  }

// img, title, catogory, location, type, salary
  _buildItemJob(JobElement item,index) {
    String IDD = item.id;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> JobDetailPage(IDD) ));
      },
      child: Container(
        color: index.isEven ? Colors.lightBlueAccent.withOpacity(0.1) : Colors.white54.withOpacity(0.1),

        // width: 150,  useless
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
                      margin: EdgeInsets.only(bottom:4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category,
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
                                text: item.category,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom:4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
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
                                text: item.location,
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
                            Icons.category_outlined,
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
                                text: item.typeJob.toString().substring(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // width: 100,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top:6,bottom:6),
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        // strutStyle: StrutStyle(fontSize:12.0),
                        child: Text("\$ " + item.salary,
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
    );
  }

}
