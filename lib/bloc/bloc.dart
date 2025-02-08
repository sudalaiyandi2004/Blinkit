import 'package:blinkit/bloc/event.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListBloc extends Bloc<ListEvent, ListState> {
 
  ListBloc()
      : super(const ListState(
          items: [],
          originalItems: [],
          filteredItems: [],
          cart:0,
          isLoading: false,
          hasMoreItems: true,
        )) {
    on<LoadItems>(_onLoadItems);
    on<LoadMoreItems>(_onLoadMoreItems);
    on<UpdateItem>(_onUpdateItem);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<ApplyFilter>(_onApplyFilter);
    on<ToggleSorting>(_onToggleSorting);
    on<counting>(_onCounting);
  }

  final int _itemsPerPage = 6;
  int _currentPage = 0;
  final List<Map<String,dynamic>> items=[{
    'id':1,
      'name':'Fresh Cow Milk',
        'img':'assets/3.jpeg',
        'val':0,
        'quantity':'1 Litre',
        'time':'30 mins',
        'rate':'Rs.30'
    },
    {
      'id':2,
      'name':'Fresh Cow Milk',
        'img':'assets/3.jpeg',
        'val':0,
        'quantity':'2 Litre',
        'time':'30 mins',
        'rate':'Rs.30'
    },
    {
      'id':3,
      'name':'Fresh Cow Milk',
        'img':'assets/3.jpeg',
        'val':0,
        'quantity':'1 Litre',
        'time':'30 mins',
        'rate':'Rs.30'
    },
    {
      'id':4,
      'name':'Fresh Cow Milk',
        'img':'assets/3.jpeg',
        'val':0,
        'quantity':'1 Litre',
        'time':'30 mins',
        'rate':'Rs.30'
    },
    {
      'id':5,
      'name':'Fresh Cow Milk',
        'img':'assets/3.jpeg',
        'val':0,
        'quantity':'1 Litre',
        'time':'30 mins',
        'rate':'Rs.30'
    },];

   
    List<dynamic> users=[];
  List<Map<String,dynamic>> phones=[];
 
  Future<List<Map<String, dynamic>>> _fetchItems({required int page}) async {
    
    final startIndex = (page - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    
    return items.sublist(startIndex, endIndex > items.length ? items.length : endIndex);
  }

  void _onLoadItems(LoadItems event, Emitter<ListState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    
    

    try {
      final newItems = await _fetchItems(page: 1);
      
      emit(state.copyWith(
        items: newItems,
        originalItems: newItems,
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
        originalItems: [...state.originalItems,...newItems],
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

  void _onUpdateItem(UpdateItem event, Emitter<ListState> emit) async{
    final updatedItems = List<Map<String, dynamic>>.from(state.items);
    //updatedItems[event.index] = event.updatedItem;
    for(var i=0;i<state.items.length;i++){
      var k=state.items[i];
      if(k['id']==event.index){
        state.items[i]=event.updatedItem;
        updatedItems[event.index-1] = event.updatedItem;
      
        //await userRepos.updateUser(updatedItems[event.index]['_id'], event.updatedItem);
      }
    }
   
      emit(state.copyWith(items: updatedItems));
    
    
  }
   void _onCounting(counting event, Emitter<ListState> emit) async{
    num vals=0;
    //updatedItems[event.index] = event.updatedItem;
    for(var i=0;i<state.items.length;i++){
      var item=state.items[i];
      vals+=item['val'];
      
        //await userRepos.updateUser(updatedItems[event.index]['_id'], event.updatedItem);
      }
      emit(state.copyWith(cart:vals));
    }
   
      
    
    
  
  void _onAddItem(AddItem event, Emitter<ListState> emit) async{
    final updatedItems = List<Map<String, dynamic>>.from(state.items);
    updatedItems.add(event.addedItem);
    
   // await userRepos.createUser(event.addedItem);
    emit(state.copyWith(items: updatedItems,originalItems: updatedItems));
    
    
  }
 void _onRemoveItem(RemoveItem event, Emitter<ListState> emit) async{
  final updatedItems = List<Map<String, dynamic>>.from(state.items);

  if (event.index < 0 || event.index >= updatedItems.length) {
    
    return;
  }

  
  final itemToRemove = updatedItems[event.index];
  final itemId = itemToRemove['_id'];

 // await userRepos.deleteUser(updatedItems[event.index]['_id']);
  updatedItems.removeAt(event.index);
  state.originalItems.removeWhere((item) => item['_id'] == itemId);
  


  
  if (state.filter == 'All') {
    emit(state.copyWith(items: updatedItems, originalItems: state.originalItems));
  } else {
    emit(state.copyWith(items: updatedItems));
  }
}


  void _onApplyFilter(ApplyFilter event, Emitter<ListState> emit) {
    final originalItems = state.originalItems;
    final filteredItems = event.filter == 'All'
        ? originalItems
        : originalItems
            .where((item) => item['showBookmark'] == event.filter)
            .toList();
    emit(state.copyWith(filter: event.filter, items: filteredItems));
  }

  void _onToggleSorting(ToggleSorting event, Emitter<ListState> emit) {
    final sortedItems = List<Map<String, dynamic>>.from(state.items);
    sortedItems.sort((a, b) {
      return event.isAscending
          ? a['name'].compareTo(b['name'])
          : b['name'].compareTo(a['name']);
    });
    emit(state.copyWith(isAscending: event.isAscending, items: sortedItems));
  }
}
