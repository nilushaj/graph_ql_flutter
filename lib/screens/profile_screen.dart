import 'package:flutter/material.dart';
import 'package:graph_ql_flutter/blocs/profile_bloc.dart';
import 'package:graph_ql_flutter/helper/constants/app_colors.dart';
import 'package:graph_ql_flutter/helper/constants/app_strings.dart';
import 'package:graph_ql_flutter/helper/utils.dart';
import 'package:graph_ql_flutter/models/RepoData.dart';
import 'package:graph_ql_flutter/models/profile_data.dart';
import 'package:graph_ql_flutter/widgets/custom_error_widget.dart';
import 'package:graph_ql_flutter/widgets/profile_widget.dart';
import 'package:graph_ql_flutter/widgets/progress_widget.dart';
import 'package:graph_ql_flutter/widgets/repo_details_widget.dart';
import 'package:graph_ql_flutter/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileBloc _profileBloc;
  final _height = Utils.totalBodyHeight;
  final _width = Utils.bodyWidth;

  @override
  void didChangeDependencies() {

    _profileBloc = Provider.of<ProfileBloc>(context);
    _profileBloc.retrieveDataFromGitHub();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACKGROUND_COLOR,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: _height*20/812),
                child: TitleWidget(
                  title: AppStrings.PROFILE_TITLE,
                  showViewAllButton: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:_height*10/812,horizontal: _width*16/345),
                child: StreamBuilder(
                    stream: _profileBloc.getProfileData,
                    builder: (context,AsyncSnapshot<ProfileData> snapshotProfileData) {
                      return snapshotProfileData.hasData?ProfileDetailsWidget(profileData: snapshotProfileData.data,):snapshotProfileData.hasError?CustomErrorWidget(errorMessage: snapshotProfileData.error,):ProgressWidget();
                    }
                ),
              ),
              TitleWidget(
                title: AppStrings.TOP_REPO_TITLE,
              ),
              ///List view builder for display top repo data
              StreamBuilder(
                  stream: _profileBloc.getTopRepoData,
                  builder: (context,AsyncSnapshot<List<RepoData>> snapshotTopRepoData) {
                    return snapshotTopRepoData.hasData?ListView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          vertical: _height *
                              10/812,horizontal: _width*16/345),
                      itemCount: snapshotTopRepoData.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: _height*10/812),
                            child: RepoDetailsWidget(repoData: snapshotTopRepoData.data[index],),
                          ),
                    ):snapshotTopRepoData.hasError?CustomErrorWidget(errorMessage: snapshotTopRepoData.error,):ProgressWidget();
                  }
              ),

              TitleWidget(
                title: AppStrings.STARRED_REPO_TITLE,
              ),
              ///List view builder for display starred repo data
              StreamBuilder(
                  stream: _profileBloc.getStarredRepoData,
                  builder: (context,AsyncSnapshot<List<RepoData>> snapshotStarredRepoData) {
                    return snapshotStarredRepoData.hasData?Container(
                      height: _height*200/812,
                      width: _width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            vertical: _height *
                                10/812,horizontal: _width*16/345),
                        itemCount: snapshotStarredRepoData.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                              padding: EdgeInsets.only(top: _height*10/812,right: _width*20/345),
                              child: RepoDetailsWidget(repoData: snapshotStarredRepoData.data[index],width: _width*200/345,),
                            ),
                      ),
                    ):snapshotStarredRepoData.hasError?CustomErrorWidget(errorMessage: snapshotStarredRepoData.error,):ProgressWidget();
                  }
              ),
              TitleWidget(
                title: AppStrings.PINNED_REPO_TITLE,
              ),
              ///List view builder for display pinned repo data
              StreamBuilder(
                  stream: _profileBloc.getPinnedRepoData,
                  builder: (context,AsyncSnapshot<List<RepoData>> snapshotPinnedRepoData) {
                    return snapshotPinnedRepoData.hasData?Container(
                      height: _height*200/812,
                      width: _width,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            vertical: _height *
                                10/812,horizontal: _width*16/345),
                        itemCount: snapshotPinnedRepoData.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                              padding: EdgeInsets.only(top: _height*10/812,right: _width*20/345),
                              child: RepoDetailsWidget(repoData: snapshotPinnedRepoData.data[index],width: _width*200/345,),
                            ),
                      ),
                    ):snapshotPinnedRepoData.hasError?CustomErrorWidget(errorMessage: snapshotPinnedRepoData.error,):ProgressWidget();
                  }
              ),
            ],

          ),
        )
      ),
    );
  }


}
