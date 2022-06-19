import 'package:project1/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/thing.dart';

class ThingModel extends Model {
  List<Thing> _things = [];
  List<Thing> _lostthings = [];
  List<Thing> _foundthings = [];
  List<Thing> _favouritethings = [];

  int _selThingIndex;
  User _authenticatedUser;
  bool _isLoading = false;

  void addThing(
    String title,
    String description,
    String date,
    String number,
    String location,
    String time,
    String image,
    String status,
  ) {
    _isLoading = true;
    final Thing newThing = Thing(
        title: title,
        date: date,
        description: description,
        number: number,
        time: time,
        image: image,
        status: status,
        location: location,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
        userName: _authenticatedUser.name);

    _things.add(newThing);
    _isLoading = false;

    notifyListeners();
  }
}

mixin ThingsModel on ThingModel {
  bool _showFavorites = false;
  int _showLost = -1;
  bool _response;
  int s;

  List<Thing> get allThings {
    return List.from(_things);
  }

  List<Thing> get displayConfirmedItems {
    return _things.where((Thing thing) => thing.confirmed).toList();
  }

  void toggleThingConfirmStatus() {
    final bool isCurrentlyConfirmed = selectedthing.confirmed;
    final bool newConfirmedStatus = !isCurrentlyConfirmed;
    final Thing updatedThing = Thing(
        title: selectedthing.title,
        date: selectedthing.date,
        description: selectedthing.description,
        number: selectedthing.number,
        time: selectedthing.time,
        image: selectedthing.image,
        status: selectedthing.status,
        location: selectedthing.location,
        userEmail: selectedthing.userEmail,
        userId: selectedthing.userId,
        userName: selectedthing.userName,
        confirmed: newConfirmedStatus);

    _things[selectedThingIndex] = updatedThing;
    notifyListeners();
  }

  void toggleThingResponseStatus(int response) {
    // final bool isCurrentlyresponsed = selectedthing.responsed;
    // final bool newresponsedStatus = !isCurrentlyresponsed;
    final Thing updatedThing = Thing(
        title: selectedthing.title,
        date: selectedthing.date,
        description: selectedthing.description,
        number: selectedthing.number,
        time: selectedthing.time,
        image: selectedthing.image,
        status: selectedthing.status,
        location: selectedthing.location,
        userEmail: selectedthing.userEmail,
        userId: selectedthing.userId,
        userName: selectedthing.userName,
        responsed: response);

    _things[selectedThingIndex] = updatedThing;
    notifyListeners();
  }

  void addConfirmData(String image, String money, String description) {
    final Thing updatedThing = Thing(
        title: selectedthing.title,
        date: selectedthing.date,
        description: selectedthing.description,
        number: selectedthing.number,
        time: selectedthing.time,
        image: selectedthing.image,
        status: selectedthing.status,
        location: selectedthing.location,
        userEmail: selectedthing.userEmail,
        userId: selectedthing.userId,
        userName: selectedthing.userName,
        confirmImage: image,
        confirmMoney: money,
        confirmDescription: description);

    _things[selectedThingIndex] = updatedThing;
    notifyListeners();
  }

  List<Thing> get displayedThings {
    if (_showFavorites && _showLost == -1) {
      return _things.where((Thing thing) => thing.isFavorite).toList();
    }
    if (_showLost == 1) {
      if (_showFavorites) {
        return _things
            .where((Thing thing) => thing.isFavorite && thing.status == 'lost')
            .toList();
      }
      return List.from(_things.where((Thing thing) => thing.status == 'lost'));
      // return _lostthings;
    }

    if (_showLost == 0) {
      if (_showFavorites) {
        return _things
            .where((Thing thing) => thing.isFavorite && thing.status == 'found')
            .toList();
      }
      return _things.where((Thing thing) => thing.status == 'found').toList();
      // return _lostthings;

    }
    return List.from(_things);
  }

  List<Thing> get displayedLostStatusItems {
    if (_showFavorites) {
      return _things
          .where((Thing thing) => thing.isFavorite && thing.status == 'lost')
          .toList();
    }
    return List.from(_things.where((Thing thing) => thing.status == 'lost'));
    // return _lostthings;
  }

  List<Thing> get displayedFoundStatusItems {
    if (_showFavorites) {
      return _things
          .where((Thing thing) => thing.isFavorite && thing.status == 'found')
          .toList();
    }
    return _things.where((Thing thing) => thing.status == 'found').toList();
    // return _lostthings;
  }

  int get displayLostOnly {
    return _showLost;
  }

  bool get response {
    return _response;
  }

  void toggleResponse(bool response) {
    _response = response;
    notifyListeners();
  }

  void toggleStatusDisplayMode(int showLost) {
    // s = -1;
    _showLost = showLost;
    notifyListeners();
  }

  int get selectedThingIndex {
    return _selThingIndex;
  }

  Thing get selectedthing {
    if (selectedThingIndex == null) {
      return null;
    }
    return _things[selectedThingIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void updateThing(String title, String description, String date, String number,
      String location, String time, String image, String status,
      [String confirmimage, String confirmmoney, String confirmdescription]) {
    final Thing updatedThing = Thing(
        title: title,
        date: date,
        description: description,
        number: number,
        time: time,
        image: image,
        status: status,
        location: location,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id,
        userName: _authenticatedUser.name,
        confirmImage: confirmimage,
        confirmMoney: confirmmoney,
        confirmDescription: confirmdescription);

    _things[selectedThingIndex] = updatedThing;
    notifyListeners();
  }

  void deleteThing() {
    _things.removeAt(selectedThingIndex);
    notifyListeners();
  }

  void toggleThingFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedthing.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Thing updatedThing = Thing(
        title: selectedthing.title,
        date: selectedthing.date,
        description: selectedthing.description,
        number: selectedthing.number,
        time: selectedthing.time,
        image: selectedthing.image,
        status: selectedthing.status,
        location: selectedthing.location,
        userEmail: selectedthing.userEmail,
        userId: selectedthing.userId,
        userName: selectedthing.userName,
        isFavorite: newFavoriteStatus);

    _things[selectedThingIndex] = updatedThing;
    notifyListeners();
  }

  void selectThing(int index) {
    _selThingIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ThingModel {
  void login(String email, String password, String name) {
    _authenticatedUser =
        User(id: 'fdalsdfasf', email: email, password: password, name: name);
  }

  void updateName(String name) {
    _authenticatedUser = User(
        id: 'fdalsdfasf',
        email: _authenticatedUser.email,
        password: _authenticatedUser.password,
        name: name);
  }
}
