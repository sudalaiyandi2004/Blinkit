abstract class ListEvent {}

class LoadItems extends ListEvent {}

class LoadMoreItems extends ListEvent {}

class UpdateItem extends ListEvent {
  final int index;
  
  
  final Map<String, dynamic> updatedItem;

  UpdateItem(this.index, this.updatedItem);
}
class AddItem extends ListEvent {
 
  
  final Map<String, dynamic> addedItem;

  AddItem(this.addedItem);
}
class RemoveItem extends ListEvent {
  final int index;

  RemoveItem(this.index);
}

class ApplyFilter extends ListEvent {
  final String filter;

  ApplyFilter(this.filter);
}

class ToggleSorting extends ListEvent {
  final bool isAscending;

  ToggleSorting(this.isAscending);
}
class counting extends ListEvent{
  
}