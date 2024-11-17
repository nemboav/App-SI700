import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/roupas.dart';
import '../provider/clothes_provider.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  BagBloc()
      : super(InsertState(
          clotheList: [],
          favoriteClotheList: [],
        )) {
    on<SubmitEvent>((event, emit) {
      ClothesProvider.helper.insertClothe(event.clothe);
    });

    on<DeleteEvent>((event, emit) {
      ClothesProvider.helper.deleteClothe(event.id);
    });

    on<UpdateAmountEvent>((event, emit) {
      ClothesProvider.helper
          .updateClotheAmount(event.clothe.id, event.clothe.amount);
    });

    on<GetClotheListEvent>((event, emit) async {
      List<StoredClothes> clotheList =
          await ClothesProvider.helper.getClotheList();
      emit(InsertState(
        clotheList: clotheList,
        favoriteClotheList: (state as InsertState)
            .favoriteClotheList, // Mantém a lista de favoritos como está
      ));
    });

    on<SubmitFavoriteEvent>((event, emit) async {
      await ClothesProvider.helper.insertFavoriteClothe(event.clothe);
      add(GetFavoriteClotheListEvent());
    });

    on<DeleteFavoriteEvent>((event, emit) {
      ClothesProvider.helper.deleteFavoriteClothe(event.id);
    });

    on<GetFavoriteClotheListEvent>((event, emit) async {
      List<StoredClothes> favoriteClotheList =
          await ClothesProvider.helper.getFavoriteClotheList();
      emit(InsertState(
        clotheList: (state as InsertState).clotheList,
        favoriteClotheList: favoriteClotheList,
      ));
    });

    // Clear the lists when logout event is triggered
    on<ClearClotheListEvent>((event, emit) {
      emit(InsertState(
        clotheList: [],
        favoriteClotheList: (state as InsertState).favoriteClotheList,
      ));
    });

    on<ClearFavoriteClotheListEvent>((event, emit) {
      emit(InsertState(
        clotheList: (state as InsertState).clotheList,
        favoriteClotheList: [],
      ));
    });
  }
}

abstract class BagEvent {}

class SubmitEvent extends BagEvent {
  final StoredClothes clothe;
  SubmitEvent({required this.clothe});
}

class DeleteEvent extends BagEvent {
  final String id;
  DeleteEvent({required this.id});
}

class UpdateAmountEvent extends BagEvent {
  final StoredClothes clothe;
  UpdateAmountEvent({required this.clothe});
}

class GetClotheListEvent extends BagEvent {}

class SubmitFavoriteEvent extends BagEvent {
  final StoredClothes clothe;
  SubmitFavoriteEvent({required this.clothe});
}

class DeleteFavoriteEvent extends BagEvent {
  final String id;
  DeleteFavoriteEvent({required this.id});
}

class GetFavoriteClotheListEvent extends BagEvent {}

class ClearClotheListEvent extends BagEvent {}

class ClearFavoriteClotheListEvent extends BagEvent {}

abstract class BagState {}

class InsertState extends BagState {
  final List<StoredClothes> clotheList;
  final List<StoredClothes> favoriteClotheList;

  InsertState({
    required this.clotheList,
    required this.favoriteClotheList,
  });
}
