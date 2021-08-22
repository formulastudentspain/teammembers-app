import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulastudent/src/business/data/helpers/data_transformer.dart';
import 'package:formulastudent/src/business/data/helpers/impl/data_transformer_impl.dart';
import 'package:formulastudent/src/business/data/repositories/firebase/team_repository_firebase_impl.dart';
import 'package:formulastudent/src/business/domain/repositories/team_repository.dart';
import 'package:formulastudent/src/business/domain/usecases/impl/team_use_cases_impl.dart';
import 'package:formulastudent/src/business/domain/usecases/team_use_cases.dart';

import 'package:get/get.dart';

class BusinessBinding implements Bindings {

  @override
  void dependencies() {

    //Data
    Get.lazyPut<DataTransformer>(() => DataTransformerImpl());
    Get.lazyPut<TeamRepository>(() => TeamRepositoryFirebaseImpl());
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance);

    //Domain
    Get.put<TeamUseCases>(TeamUseCasesImpl());
  }
}
