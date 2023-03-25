import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_oneplanet/theme/colors.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add a New Post",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: AppColors.kDarkGreen),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.info,
                    color: Colors.grey,
                  ),
                  labelText: 'Title',
                  hintText: 'Type here something',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 1,
                  shape: const StadiumBorder(),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    "Post",
                    style: GoogleFonts.poppins(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
