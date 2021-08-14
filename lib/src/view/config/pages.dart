import 'package:formulastudent/src/view/config/page_bindings.dart';
import 'package:formulastudent/src/view/pages/chat/chat_page.dart';
import 'package:formulastudent/src/view/pages/faq/faq_page.dart';
import 'package:formulastudent/src/view/pages/myteam/my_team_page.dart';
import 'package:formulastudent/src/view/pages/teams/teams_page.dart';
import 'package:formulastudent/src/view/pages/timeline/timeline_page.dart';
import 'package:get/get.dart';

List<GetPage> getApplicationPages() {
  return [
    GetPage(
      name: '/timeline',
      page: () => TimelinePage(),
      binding: TimelinePageBinding(),
    ),
    GetPage(
      name: '/chat',
      page: () => ChatPage(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: '/faq',
      page: () => FaqPage(),
      binding: FaqPageBinding(),
    ),
    GetPage(
      name: '/myteam',
      page: () => MyTeamPage(),
      binding: MyTeamPageBinding(),
    ),
    GetPage(
      name: '/teams',
      page: () => TeamsPage(),
      binding: TeamsPageBinding(),
    )
  ];
}
