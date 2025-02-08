class ListState {
  final List<Map<String, dynamic>> items;
  final List<Map<String, dynamic>> originalItems;
  final List<Map<String, dynamic>> filteredItems;
  final bool isLoading;
  final num cart;
  final bool hasMoreItems;
  final String filter;
  final bool isAscending;
  final String errorMessage;

  const ListState({
    required this.items,
    required this.cart,
    required this.originalItems,
    required this.filteredItems,
    required this.isLoading,
    required this.hasMoreItems,
    this.filter = 'All',
    this.isAscending = true,
    this.errorMessage = '',
  });

  ListState copyWith({
    List<Map<String, dynamic>>? items,
    List<Map<String, dynamic>>? originalItems,
    List<Map<String, dynamic>>? filteredItems,
    bool? isLoading,
    num? cart,
    bool? hasMoreItems,
    String? filter,
    bool? isAscending,
    String? errorMessage,
  }) {
    return ListState(
      items: items ?? this.items,
      cart:cart ?? this.cart,
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
