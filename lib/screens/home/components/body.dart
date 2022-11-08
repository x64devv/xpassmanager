import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/components/account_results.dart';
import 'package:xpassmanager/components/input_field.dart';
import 'package:xpassmanager/components/lottie_widget.dart';
import 'package:xpassmanager/components/pass_entry.dart';
import 'package:xpassmanager/components/search_field.dart';
import 'package:xpassmanager/model/datase_helper.dart';
import 'package:xpassmanager/model/user_model.dart';
import 'package:xpassmanager/screens/home/components/add_account_sheet.dart';
import 'package:xpassmanager/screens/home/components/add_button.dart';
import 'package:xpassmanager/screens/home/components/add_cartegory.dart';
import 'package:xpassmanager/screens/profile/profile_sheet.dart';
import '../../../components/avatar_card.dart';
import '../../../model/cartegory_model.dart';
import '../../../model/password_model.dart';
import '../../constants.dart';

class Body extends StatefulWidget {
  final UserModel user;

  Body({super.key, required this.user});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String searchText = "";

  //profile image
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: kColorSecondary,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              top: 28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu_rounded,
                            color: kColorPrimary,
                          ))),
                  IconButton(
                    onPressed: () {
                      showBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return ProfileSheet(user: widget.user);
                          });
                    },
                    icon: AvatarCard(
                      image: widget.user.avatarPath!,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: size.height * 0.15,
                left: 16,
                child: RichText(
                  text: TextSpan(
                      text: "Welcome Back!\n\n",
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: kColorAccent,
                          fontWeight: FontWeight.normal),
                      children: [
                        TextSpan(
                          text: "${widget.user.name}",
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: kColorAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                )),
            Positioned(
              top: size.height * 0.25,
              right: 16,
              left: 16,
              child: SearchField(searchFxn: (value) {
                showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return AccoutResultsSheet(
                        cartegory: CartegoryModel(),
                        isSearch: true,
                        size: size,
                        searchQuery: value,
                      );
                    });
              }),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: size.height * 0.63,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cartegories",
                                style: textStyle(true, 16, color: kColorAccent),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return AddCartegorySheet(
                                                size: size,
                                                saveCartegory: (cartegory) {
                                                  addCartegory(cartegory)
                                                      .then((success) {
                                                    setState(() {
                                                      if (success) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  "Adding ${cartegory.cartegoryName} successfull",
                                                                  style: textStyle(
                                                                      true, 16,
                                                                      color:
                                                                          kColorAccent),
                                                                ),
                                                                content:
                                                                    Container(
                                                                  height:
                                                                      size.height *
                                                                          0.4,
                                                                  width:
                                                                      size.width *
                                                                          0.6,
                                                                  child: Column(
                                                                    children: [
                                                                      LottieWidget(
                                                                        lottieAnimation:
                                                                            "assets/lottie/lottie_done.json",
                                                                        size:
                                                                            size,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Close",
                                                                            style: textStyle(true,
                                                                                16,
                                                                                color: kColorSecondary),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      }
                                                    });
                                                  });
                                                });
                                          });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_box_rounded,
                                    color: kColorAccent,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.only(left: 16),
                          child: FutureBuilder(
                            initialData: const <CartegoryModel>[],
                            future: fetchCartegories(),
                            builder: (context,
                                AsyncSnapshot<List<CartegoryModel>> snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var cartegory = snapshot.data![index];
                                      return InkWell(
                                        onTap: () {
                                          showBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) {
                                                return AccoutResultsSheet(
                                                  cartegory: cartegory,
                                                  isSearch: false,
                                                  size: size,
                                                );
                                              });
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          child: Column(
                                            children: [
                                              AvatarCard(
                                                  image: cartegory.avatarPath!),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                cartegory.cartegoryName!,
                                                style: textStyle(false, 12,
                                                    color: kColorAccent),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Add cartegory and they will show here",
                                  style:
                                      textStyle(false, 12, color: kColorAccent),
                                ),
                              );
                            },
                          ),
                        ),

                        //Below its going to list all the passwords/accounts saved sorted by latest entry date
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "Latest",
                            style: textStyle(true, 16, color: kColorAccent),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: FutureBuilder(
                              initialData: <PasswordModel>[],
                              future: fetchPasswords(),
                              builder: (context,
                                  AsyncSnapshot<List<PasswordModel>> snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                      var lastDate = "";
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...List.generate(snapshot.data!.length,
                                            (index) {
                                          PasswordModel currentPass =
                                              snapshot.data![index];
                                          if (currentPass.dateAdded !=
                                              lastDate) {
                                            lastDate = currentPass.dateAdded!;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "${currentPass.dateAdded}",
                                                  style: textStyle(true, 14,
                                                      color: kColorAccent),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                PassWordEntry(
                                                    avatar: AvatarCard(
                                                        image: currentPass
                                                            .siteIcon!),
                                                    name: currentPass.name!,
                                                    user: currentPass.user!,
                                                    pass: currentPass.pass!),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                              ],
                                            );
                                          }
                                          return PassWordEntry(
                                              avatar: AvatarCard(
                                                  image: currentPass.siteIcon!),
                                              name: currentPass.name!,
                                              user: currentPass.user!,
                                              pass: currentPass.pass!);
                                        })
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                )),

            //This positioned widget houses the add button
            //When the add button is pressed it pops up the add password/account (the spoils of inconsistent naming) bottomsheet
            //A fuction is passed to is from this pages so that when is executes setstate() is done on the body widget not the bottom sheet(hopefully)
            //then in the setstate() appropriate dialogs for adding password/account status
            Positioned(
                bottom: 8,
                right: 16,
                child: AddButton(onTap: () {
                  showBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        PasswordModel passwordModel = PasswordModel();
                        return AccountSheet(
                          size: size,
                          passwordModel: passwordModel,
                          savePassword: (password) {
                            addPassword(password).then((success) {
                              if (success) {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Adding Password for ${password.name} successfull",
                                            style: textStyle(true, 16,
                                                color: kColorAccent),
                                          ),
                                          content: Container(
                                            height: size.height * 0.4,
                                            width: size.width * 0.6,
                                            child: Column(
                                              children: [
                                                LottieWidget(
                                                  lottieAnimation:
                                                      "assets/lottie/lottie_done.json",
                                                  size: size,
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Close",
                                                      style: textStyle(true, 16,
                                                          color:
                                                              kColorSecondary),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                              }
                            });
                          },
                        );
                      });
                })),
          ],
        ),
      ),
    );
  }
}
