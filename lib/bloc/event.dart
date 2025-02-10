  abstract class ListEvent {}

  class LoadItems extends ListEvent {}

  class LoadMoreItems extends ListEvent {}

  class UpdateItem extends ListEvent {
    final String index;
    
    
    final Map<String, dynamic> updatedItem;

    UpdateItem(this.index, this.updatedItem);
  }
  class AddItem extends ListEvent {
  
    
    final Map<String, dynamic> addedItem;

    AddItem(this.addedItem);
  }
  class RemoveItem extends ListEvent {
    final String index;

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
  // ignore: camel_case_types
  class counting extends ListEvent{
    
  }
  // ignore: camel_case_types
  class updateIndex extends ListEvent{
    late final int indexs;

    updateIndex(this.indexs);

  }