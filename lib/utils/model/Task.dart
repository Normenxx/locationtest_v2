import 'User.dart';

class Task {
  String _name;
  int _maxWorkerAmount;
  List<User> _workers;
  String _description;
  String _location;
  DateTime _date;
  DateTime _start;
  DateTime _end;

  Task(this._name, this._maxWorkerAmount) {
    _workers = new List(_maxWorkerAmount);
  }

  String getName(){
    return this._name;
  }
}