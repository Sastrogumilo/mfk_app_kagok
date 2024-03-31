import 'package:flutter/material.dart';
//import sharedprefrences
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kagok_app/screen/widget/home/home_menu_widget.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({super.key});

  @override
  // _ProfilePage1State createState() => _ProfilePage1State();
  State<ProfilePage1> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  bool _showImage = false; // Flag to control image visibility
  bool _isTopPortionExpanded = false;

  String namaUser = "User";

  static const ColorFilter greyscale = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  //init state
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaUser = prefs.getString('nama') ??
          "User"; // Provide a default value if 'nama' is not found
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showImage = !_showImage; // Toggle image visibility on tap
                _isTopPortionExpanded = !_isTopPortionExpanded;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _isTopPortionExpanded ? 400 : 200,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromARGB(255, 8, 183, 113),
                          Color.fromARGB(255, 3, 240, 62)
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  // Conditionally show the image with fade-in animation
                  SizedBox(
                    child: Visibility(
                        visible: _isTopPortionExpanded,
                        child: Stack(
                          children: [
                            Positioned(
                                right: (MediaQuery.of(context).size.width / 2) *
                                    0.1,
                                top: 50,
                                child: const Text(
                                  "Pagi Yang Cerah\nUntuk Jiwa Yang Sepi",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                )),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [Colors.transparent, Colors.grey],
                                  stops: [0.001, 1],
                                ).createShader(bounds);
                              },
                              child: ColorFiltered(
                                colorFilter: greyscale,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/images/kagok_lama_crop_trans.png',
                                  image:
                                      // image of puskesmas
                                      "https://lh3.googleusercontent.com/drive-viewer/AKGpiha6CxP-8mBz6rpS58yXk3GWqBPE0qq6yyrV5Zv9drwqpYUiTq5wP2DOb04JgLReEf0Lgz6l7wpiptBy9mf9nyaXnqJl=w1341-h890-v0",
                                  fadeInDuration:
                                      const Duration(milliseconds: 1000),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width >=
                                          504
                                      ? 400
                                      : MediaQuery.of(context).size.width - 50,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: 150,
                        height: 150,
                        child: _TopPortion(showImage: _showImage)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  namaUser,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                FutureBuilder<Widget>(
                  future: homeMenu(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data ?? Container();
                    }
                  },
                ),
                const SizedBox(height: 16),
                const _ProfileInfoRow()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow();

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                  child: Row(
                    children: [
                      if (_items.indexOf(item) != 0) const VerticalDivider(),
                      Expanded(child: _singleItem(context, item)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({required this.showImage});

  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.transparent, Colors.transparent]),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        // Conditionally show the image with fade-in animation

        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Container for profile picture border (always visible)
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                  ),
                  child: Visibility(
                    // Hide the black circle when image is visible
                    visible: !showImage,
                    child: const CircleAvatar(
                      radius:
                          75, // Adjust radius to cover most of the container
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showSettingsWidget(BuildContext context) {}
