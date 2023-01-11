import 'dart:convert';

import 'package:course_discuss/config/api.dart';
import 'package:course_discuss/config/app_format.dart';
import 'package:course_discuss/config/app_route.dart';
import 'package:course_discuss/config/session.dart';
import 'package:course_discuss/controller/c_account.dart';
import 'package:course_discuss/controller/c_home.dart';
import 'package:course_discuss/controller/c_user.dart';
import 'package:course_discuss/model/user.dart';
import 'package:course_discuss/source/user_source.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({super.key});

  // function logout
  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'Tap yes to logout.!!',
    ).then((yes) {
      // jika menekan yes maka true, jika tidak maka false
      if (yes ?? false) {
        Session.clearUser().then((success) {
          // jika true jalankan session clear user,
          if (success) {
            context.read<CUser>().data =
                null; // jika sukses, jalankan controller user dan datanya ubah jadi null
            context.read<CHome>().indexMenu =
                0; // jalankan juga controller home , ubah indexmenu ke 0
            context.go(AppRoute.login); // kembalikan ke route utama (login)
          }
        });
      }
    });
  }

  // function ubah gambar
  updateImage(BuildContext context) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        // ambil data user dulu agar bisa di update (id dan nama image)
        String idUser = context.read<CUser>().data!.id;
        String oldImage = context.read<CUser>().data!.image;

        DInfo.dialogConfirmation(context, 'Update', 'Yesto confirm')
            .then((yes) async {
          if (yes ?? false) {
            String name = image
                .name; // ambil nama imagenya dulu supaya bisa diubah ke base64code
            Uint8List bytes = await image.readAsBytes();

            // panggil function ubah gambar
            UserSource.updateImage(idUser, oldImage, name, base64Encode(bytes))
                .then((success) {
              if (success) {
                // jika sukksess ambil data lama, dan yang diubah hanya image saja
                User? newUser = context.read<CUser>().data!..image = name;
                context.read<CUser>().data =
                    newUser; // ubah data lamam dengan data baru
                Session.setUser(newUser); // update session

                DInfo.snackBarSuccess(context, 'Success Update Image');
              } else {
                DInfo.snackBarError(context, 'Update Image Failed');
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthBoxImage = MediaQuery.of(context).size.width * 0.5;

    // panggil controller
    var cUser = context.read<CUser>(); // untuk mengambil foto profil
    var cAccount = context.read<CAccount>(); // untuk mengambil statistik data

    // jika usernya kosong
    if (cUser.data == null) return DView.empty();
    cAccount.setStat(cUser.data!.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DView.textTitle('Account'),
        ),
        DView.spaceHeight(30),
        Center(
          child: SizedBox(
            width: widthBoxImage,
            height: widthBoxImage,
            child: Stack(
              children: [
                Container(
                  width: widthBoxImage,
                  height: widthBoxImage,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 3),
                      )
                    ],
                  ),
                ),

                // gambar profil
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(90),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Consumer<CUser>(
                        // agar terupdate
                        builder: (contextConsumerUser, _, child) {
                          return Image.network(
                            '${Api.imageUser}/${_.data!.image}',
                            fit: BoxFit.cover,
                            width: widthBoxImage - 20,
                            height: widthBoxImage - 20,
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        DView.spaceHeight(16),

        // tampil username dan tombol image
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: DView.textTitle(context.watch<CUser>().data!.username,
                  color: Colors.white), // agar terupdate otomatis
            ),
            DView.spaceWidth(),
            SizedBox(
              height: 30,
              child: ElevatedButton.icon(
                onPressed: () => updateImage(context),
                icon: const Icon(
                  Icons.edit,
                  size: 14,
                ),
                label: const Text('Image'),
              ),
            )
          ],
        ),

        // keterangan stats
        Consumer<CAccount>(
          builder: (contextConsumer, _, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // tpic
                      Expanded(child: itemStat('Topic', _.stat['topic'])),
                      Container(
                        color: Colors.grey,
                        height: 30,
                        width: 0.5,
                      ),

                      // follower
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.push(AppRoute.follower,
                                extra: context.read<CUser>().data);
                          },
                          child: itemStat('Follower', _.stat['follower']),
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 30,
                        width: 0.5,
                      ),

                      // following
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.push(AppRoute.following,
                                extra: context.read<CUser>().data);
                          },
                          child: itemStat('Following', _.stat['following']),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        DView.spaceHeight(8),

        // tombol logout
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => logout(context),
            child: const Text('Logout'),
          ),
        )
      ],
    );
  }

  Widget itemStat(String title, num value) {
    return Column(
      children: [
        Text(title),
        DView.spaceHeight(4),
        DView.textTitle(
          AppFormat.infoNumber(value.toDouble()),
        ),
      ],
    );
  }
}
