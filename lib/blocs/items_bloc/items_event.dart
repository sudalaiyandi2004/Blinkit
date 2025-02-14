part of 'items_bloc.dart';



@immutable
abstract class AppEvent {}

class CallItemsApi extends AppEvent {

  
}
class GetCartValue extends AppEvent {

  
}
  class UpdateItems extends AppEvent {
    final String index;
    final String operation;
    
    final Items updatedItem;

    UpdateItems(this.index, this.updatedItem,this.operation);
  }
  
  class Countings extends AppEvent{
    final String op;
    Countings(this.op);
  }
  
  class UpdateIndexs extends AppEvent{
    late final int indexs;

    UpdateIndexs(this.indexs);

  }
