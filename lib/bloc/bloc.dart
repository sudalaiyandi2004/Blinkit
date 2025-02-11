import 'package:blinkit/bloc/api.dart';
import 'package:blinkit/bloc/event.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final UserRepositors userRepos;
  ListBloc({required this.userRepos})
      : super(const ListState(
          items: [],
          originalItems: {},
          filteredItems: [],
          ind: 0,
          cart: 0,
          isLoading: false,
          hasMoreItems: true,
        )) {
    on<LoadItems>(_onLoadItems);
    on<LoadMoreItems>(_onLoadMoreItems);
    on<UpdateItem>(_onUpdateItem);
    
    on<counting>(_onCounting);
    on<updateIndex>(_onUpdateIndex);
  }

  final int _itemsPerPage = 6;
  int _currentPage = 0;
  List<Map<String, dynamic>> products = [];

  List<dynamic> users = [];
  

  Future<List<Map<String, dynamic>>> _fetchItems({required int page}) async {
    final startIndex = (page - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return products.sublist(startIndex, endIndex > products.length ? products.length : endIndex);
  }


  void _onLoadItems(LoadItems event, Emitter<ListState> emit) async {
    if (state.isLoading) return;

    var ite = await userRepos.fetchItems();
    var ites=await userRepos.fetchBanner();
    List<Map<String, dynamic>> convertToMapList(List<dynamic> dynamicList) {
  return dynamicList.whereType<Map<String, dynamic>>().toList();
}
    List<Map<String, dynamic>> banner = [];
    banner=convertToMapList(ites);
    
    products = ite.map((item) => Map<String, dynamic>.from(item)).toList();

    Map<String, List<Map<String, dynamic>>> categorizedItems = {};

    for (var item in ite) {
      categorizedItems.putIfAbsent(item['category'], () => []).add(item);
    }

    emit(state.copyWith(isLoading: true));

    try {
      final newItems = await _fetchItems(page: 1);

      emit(state.copyWith(
        items: newItems,
        filteredItems: banner,
        originalItems: Map<String, List<Map<String, dynamic>>>.from(categorizedItems),
        isLoading: false,
        hasMoreItems: newItems.length >= _itemsPerPage,
      ));
      _currentPage = 1;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load items',
      ));
    }
  }

  void _onLoadMoreItems(LoadMoreItems event, Emitter<ListState> emit) async {
    if (state.isLoading || !state.hasMoreItems) return;

    emit(state.copyWith(isLoading: true));

    try {
      final newItems = await _fetchItems(page: _currentPage + 1);
      emit(state.copyWith(
        items: [...state.items, ...newItems],
        isLoading: false,
        hasMoreItems: newItems.length >= _itemsPerPage,
      ));
      _currentPage++;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load more items',
      ));
    }
  }

 void _onUpdateItem(UpdateItem event, Emitter<ListState> emit) async {
 
  final updatedItems = Map<String, List<Map<String, dynamic>>>.from(state.originalItems);

 
  String category = '';  
  bool itemUpdated = false;

  
  updatedItems.forEach((key, value) {
    
    for (var i = 0; i < value.length; i++) {
      var item = value[i];
    
      if (item['_id'] == event.index) {  
    
        category = key;
        updatedItems[key]?[i] = event.updatedItem; 
      
        itemUpdated = true;
        break;
      }
    }
  });

  if (itemUpdated) {
    
    emit(state.copyWith(
      originalItems: updatedItems,
      items: updatedItems[category] ?? [],  
    ));
  } else {

    emit(state.copyWith(
      errorMessage: "Item with _id ${event.updatedItem['_id']} not found",
    ));
  }
}


  void _onCounting(counting event, Emitter<ListState> emit) async {
    num vals = 0;
   if(event.op=='add'){
    vals=state.cart+1;
   }
   else{
    vals=state.cart-1;
   }
    emit(state.copyWith(cart: vals)); 
  }


  void _onUpdateIndex(updateIndex event, Emitter<ListState> emit) async {
    int vals = event.indexs;
    emit(state.copyWith(ind: vals)); 
  }
}
