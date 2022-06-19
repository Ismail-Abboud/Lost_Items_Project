import 'package:scoped_model/scoped_model.dart';

import './things.dart';

class MainModel extends Model with ThingModel, UserModel, ThingsModel {}
