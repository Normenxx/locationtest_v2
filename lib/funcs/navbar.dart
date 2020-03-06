import 'package:flutter/material.dart';
import 'package:locationtest_v2/pages/calendarEvent.dart';
import 'package:locationtest_v2/pages/calendarShift_WA.dart';
import 'package:locationtest_v2/pages/calendarShift_ZA.dart';
import 'package:locationtest_v2/pages/homepage.dart';
import 'package:locationtest_v2/pages/settings.dart';
import 'package:locationtest_v2/pages/timestamp.dart';
import 'package:locationtest_v2/pages/MapPage.dart';
import 'package:locationtest_v2/pages/AttendancePage.dart';
import 'package:locationtest_v2/pages/LocationListPage.dart';


class NavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            accountName: Text('Gianluca Fontanella'),
            accountEmail: Text('gfontanella@tsn.at'),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
              NetworkImage('https://www.denverfamilytherapycenter.com/sites/default/files/styles/clinician_profile_thumb/public/default_images/defaultPic-dftc.jpg?itok=7iwJDdNo'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Startseite'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Zeitstempeln'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Attendance())),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Kalender-Schicht-ZA'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarShiftZA())),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Kalender-Schicht-WA'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarShiftWA())),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Kalender-Event'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarEvent())),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Einstellungen'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings())),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Google Map'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Map())),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Standort Liste'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationListPage())),
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Abmelden'),
          ),
        ],
      ),
    );
  }
}