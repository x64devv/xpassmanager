import 'package:flutter/material.dart';
import 'package:xpassmanager/components/avatar_card.dart';
import 'package:xpassmanager/components/loading_page.dart';
import 'package:xpassmanager/components/lottie_widget.dart';
import 'package:xpassmanager/components/pass_entry.dart';
import 'package:xpassmanager/model/cartegory_model.dart';
import 'package:xpassmanager/model/datase_helper.dart';
import 'package:xpassmanager/model/password_model.dart';
import 'package:xpassmanager/screens/constants.dart';

class AccoutResultsSheet extends StatefulWidget {
  AccoutResultsSheet(
      {super.key,
      this.searchQuery = "",
      this.isSearch = false,
      required this.size,
      required this.cartegory});
  String searchQuery;
  bool isSearch;
  final CartegoryModel cartegory;
  Size size;
  @override
  State<AccoutResultsSheet> createState() => _AccoutResultsSheetState();
}

class _AccoutResultsSheetState extends State<AccoutResultsSheet> {
  bool loading = true;
  late Future<List<PasswordModel>> passwords;
  String title = "";
  @override
  Widget build(BuildContext context) {
    if (widget.isSearch) {
      title = "Results for ${widget.searchQuery}";
      searchForMatch(widget.searchQuery);
    } else {
      title = "Password in ${widget.cartegory.cartegoryName} cartegory.";
      searchForId(widget.cartegory.id!);
    }
    return Container(
      child: loading
          ? const LoadingPage()
          : Container(
              height: widget.size.height * 0.95,
              width: widget.size.width,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                  color: kColorPrimary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: kColorAccent)),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        title,
                        style: textStyle(true, 16, color: kColorAccent),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                    initialData: <PasswordModel>[],
                    future: passwords,
                    builder:
                        (context, AsyncSnapshot<List<PasswordModel>> snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Expanded(
                          child: Container(
                            height: widget.size.height * 0.75,
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var password = snapshot.data![index];
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 8, top: 8),
                                    child: PassWordEntry(
                                        avatar: AvatarCard(
                                            image: password.siteIcon!),
                                        name: password.name!,
                                        user: password.user!,
                                        pass: password.pass!),
                                  );
                                }),
                          ),
                        );
                      }
                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            LottieWidget(
                              lottieAnimation:
                                  "assets/lottie/lottie_error.json",
                              size: widget.size,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Opps!!, No passwords found!",
                              style: textStyle(false, 16, color: kColorAccent),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  searchForId(int id) async {
    passwords = searchPasswordWithId(id).then((result) {
      setState(() {
        loading = false;
      });
      return result;
    });
  }

  searchForMatch(String q) async {
    passwords = searchPasswordWithMatch(q).then((result) {
      setState(() {
        loading = false;
      });
      return result;
    });
  }
}
