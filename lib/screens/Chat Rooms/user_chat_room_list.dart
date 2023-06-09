import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_oneplanet/helper/firestore_methods.dart';
import 'package:project_oneplanet/models/Event.dart';
import 'package:project_oneplanet/screens/Chat%20Rooms/event_chat_room.dart';

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  List<EventModel> _myEvents = [];

  void setMyEvent() async {
    List<EventModel> res =
        await FirestoreMethods().getAllChatRoomsOfCurrentUser();
    setState(() {
      _myEvents = res;
    });
  }

  @override
  void initState() {
    super.initState();
    setMyEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _myEvents.length,
          itemBuilder: (ctx, idx) => ChatListWidget(
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventChatRoom(
                    eventId: _myEvents[idx].eventID,
                  ),
                ),
              );
            },
            title: _myEvents[idx].title,
            locationname: _myEvents[idx].location,
            members: _myEvents[idx].participants.length.toString(),
            type: _myEvents[idx].type,
          ),
        ),
      ),
    );
  }
}

class ChatListWidget extends StatelessWidget {
  final String title;
  final String locationname;
  final String members;
  final String type;
  final Function ontap;

  ChatListWidget({
    required this.ontap,
    required this.locationname,
    required this.members,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: BoxDecoration(
          color: _colorFromType(type),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(6, 6),
            ),
          ],
        ),
        child: ListTile(
          trailing: Image.asset('assets/images/${type}_sqare.png'),
          title: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
              fontSize: 23,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locationname,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${members} Members',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.7),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _colorFromType(String type) {
  if (type == "donation") {
    return Color(0xFFDDA63A);
  } else if (type == "life-on-land") {
    return Color(0xFF5CC02B);
  } else if (type == "sustainable-cities") {
    return Color(0xFFF49C31);
  } else if (type == "cleanliness") {
    return Color(0xFF4BBDE2);
  }

  return Colors.white;
}
