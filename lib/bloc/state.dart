class ListState {
  final List<Map<String, dynamic>> items;
  final Map<String, List<Map<String, dynamic>>> originalItems;
  final List<Map<String, dynamic>> filteredItems;
  final int ind;
  final bool isLoading;
  final num cart;
  final bool hasMoreItems;
  final String filter;
  final int indexs;
  final bool isAscending;
  final String errorMessage;

  const ListState({
    required this.items,
    required this.cart,
    required this.originalItems,
    required this.filteredItems,
    required this.ind,
    required this.isLoading,
    required this.hasMoreItems,
    this.filter = 'All',
    this.indexs = 0,
    this.isAscending = true,
    this.errorMessage = '',
  });

  ListState copyWith({
    List<Map<String, dynamic>>? items,
    Map<String, List<Map<String, dynamic>>>? originalItems,
    List<Map<String, dynamic>>? filteredItems,
    bool? isLoading,
    num? cart,
    int? ind,
    int? indexs,
    bool? hasMoreItems,
    String? filter,
    bool? isAscending,
    String? errorMessage,
  }) {
    return ListState(
      items: items ?? this.items,
      cart: cart ?? this.cart,
      ind: ind ?? this.ind,
      indexs: indexs ?? this.indexs,
      originalItems: originalItems ?? this.originalItems,
      filteredItems: filteredItems ?? this.filteredItems,
      isLoading: isLoading ?? this.isLoading,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
      filter: filter ?? this.filter,
      isAscending: isAscending ?? this.isAscending,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
