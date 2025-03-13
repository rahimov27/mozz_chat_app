import 'package:flutter/material.dart';
import 'package:mozz_chat_app/chat_screen.dart';
import 'package:mozz_chat_app/theme/app_colors.dart';
import 'package:mozz_chat_app/widgets/app_bar_title_widget.dart';
import 'package:mozz_chat_app/widgets/app_chat_widget_row.dart';
import 'package:mozz_chat_app/widgets/app_search_field_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<AppChatWidgetRow> chats = [
    AppChatWidgetRow(
      firstName: "Виктор",
      lastName: "Власов",
      date: "Вчера",
      color1: AppColors.green1,
      color2: AppColors.green2,
    ),
    AppChatWidgetRow(
      firstName: "Саша",
      lastName: "Алексеев",
      date: "12.01.22",
      color1: AppColors.red1,
      color2: AppColors.red2,
    ),
    AppChatWidgetRow(
      firstName: "Пётр",
      lastName: "Жаринов",
      date: "2 минуты назад",
      color1: AppColors.green1,
      color2: AppColors.green2,
    ),
    AppChatWidgetRow(
      firstName: "Алина",
      lastName: "Жукова",
      date: "09:23",
      color1: AppColors.red1,
      color2: AppColors.red2,
    ),
  ];

  List<AppChatWidgetRow> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = chats;
    _searchController.addListener(_filterChats);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterChats);
    _searchController.dispose();
    super.dispose();
  }

  void _filterChats() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChats =
          chats.where((chat) {
            return chat.firstName.toLowerCase().contains(query) ||
                chat.lastName.toLowerCase().contains(query);
          }).toList();
    });
  }

  void _deleteChat(int index) {
    setState(() {
      _filteredChats.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarTitleWidget(), centerTitle: false),
      body: SafeArea(
        child: Column(
          children: [
            AppSearchFieldWidget(controller: _searchController),
            SizedBox(height: 24),
            Divider(color: AppColors.textFieldColor),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredChats.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(_filteredChats[index].firstName),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteChat(index);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Delete")));
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ChatScreen(
                                  firstName: _filteredChats[index].firstName,
                                  lastName: _filteredChats[index].lastName,
                                  color1: _filteredChats[index].color1,
                                  color2: _filteredChats[index].color2,
                                ),
                          ),
                        );
                      },
                      child: AppChatWidgetRow(
                        firstName: _filteredChats[index].firstName,
                        lastName: _filteredChats[index].lastName,
                        date: _filteredChats[index].date,
                        color1: _filteredChats[index].color1,
                        color2: _filteredChats[index].color2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
