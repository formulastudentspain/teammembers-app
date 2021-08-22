import 'package:formulastudent/src/view/config/page_bindings.dart';
import 'package:formulastudent/src/view/pages/chat/chat_page.dart';
import 'package:formulastudent/src/view/pages/faq/faq_page.dart';
import 'package:formulastudent/src/view/pages/myteam/my_team_page.dart';
import 'package:formulastudent/src/view/pages/teams/teams_page.dart';
import 'package:formulastudent/src/view/pages/teamsdetail/teams_detail_page.dart';
import 'package:formulastudent/src/view/pages/timeline/timeline_page.dart';
import 'package:get/get.dart';

List<GetPage> getApplicationPages() {
  return [
    GetPage(
        name: '/timeline',
        page: () => TimelinePage(),
        binding: TimelinePageBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/chat',
        page: () => ChatPage(),
        binding: ChatPageBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/faq',
        page: () => FaqPage(),
        binding: FaqPageBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/myTeam',
        page: () => MyTeamPage(),
        binding: MyTeamPageBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/teams',
        page: () => TeamsPage(),
        binding: TeamsPageBinding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: '/teamsDetail',
        page: () => TeamsDetailPage(),
        binding: TeamsDetailPageBinding(),
        transition: Transition.rightToLeft)
  ];
}
