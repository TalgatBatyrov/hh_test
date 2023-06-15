import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/user_info/user_info_cubit.dart';
import '../../../../blocs/user_info/user_info_state.dart';
import '../../../helper/app_error.dart';
import '../../../helper/app_loading.dart';

class UserInfo extends StatelessWidget implements PreferredSizeWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM, yyyy').format(now);
    final userInfoCubit = context.read<UserInfoCubit>();
    return AspectRatio(
      aspectRatio: 16 / 3,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: BlocBuilder<UserInfoCubit, UserInfoState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const AppLoading(),
              loading: (_) => const AppLoading(),
              loaded: (loadedState) => AppBar(
                leadingWidth: 18,
                leading: IconButton(
                  icon: const Icon(Icons.location_on_outlined, size: 30),
                  onPressed: userInfoCubit.getUserLocation,
                ),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loadedState.country,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(formattedDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          )),
                    ],
                  ),
                ),
                actions: const [CircleAvatar(backgroundImage: AssetImage('assets/images/user.png'))],
              ),
              error: (errorState) => ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.location_on_outlined),
                  onPressed: userInfoCubit.getUserLocation,
                ),
                title: AppError(errorState.message),
                subtitle: Text(formattedDate),
                trailing: const Icon(Icons.search),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
