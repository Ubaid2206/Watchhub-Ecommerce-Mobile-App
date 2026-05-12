import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/watch_model.dart';
import '../../widgets/watch_card.dart';
import '../product/product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<WatchModel> _searchResults = [];
  bool _isSearching = false;
  String _selectedBrand = 'All';
  RangeValues _priceRange = const RangeValues(0, 10000);

  final List<String> _brands = [
    'All',
    'Rolex',
    'Omega',
    'TAG Heuer',
    'Apple',
    'Seiko',
  ];

  final List<WatchModel> _allWatches = [
    WatchModel(
      id: '1',
      name: 'Rolex Submariner',
      brand: 'Rolex',
      price: 8950.00,
      description: 'Iconic dive watch with water resistance up to 300 meters',
      images: ['https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?w=500'],
      category: 'Luxury',
      stock: 5,
      rating: 4.8,
      reviewCount: 124,
      specifications: {
        'Movement': 'Automatic',
        'Case Size': '41mm',
        'Water Resistance': '300m',
      },
    ),
    WatchModel(
      id: '2',
      name: 'Apple Watch Series 9',
      brand: 'Apple',
      price: 399.00,
      description: 'Advanced smartwatch with health tracking features',
      images: ['https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500'],
      category: 'Smart',
      stock: 20,
      rating: 4.6,
      reviewCount: 856,
      specifications: {
        'Display': 'OLED Retina',
        'Case Size': '45mm',
      },
    ),
    WatchModel(
      id: '3',
      name: 'Omega Speedmaster',
      brand: 'Omega',
      price: 6500.00,
      description: 'Legendary moonwatch with chronograph function',
      images: ['https://images.unsplash.com/photo-1611881263478-775a4e6f0d3e?w=500'],
      category: 'Luxury',
      stock: 8,
      rating: 4.9,
      reviewCount: 234,
      specifications: {
        'Movement': 'Manual',
        'Case Size': '42mm',
      },
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _searchResults = _allWatches.where((watch) {
          final matchesQuery = watch.name.toLowerCase().contains(query.toLowerCase()) ||
              watch.brand.toLowerCase().contains(query.toLowerCase());
          final matchesBrand = _selectedBrand == 'All' || watch.brand == _selectedBrand;
          final matchesPrice = watch.price >= _priceRange.start && watch.price <= _priceRange.end;
          
          return matchesQuery && matchesBrand && matchesPrice;
        }).toList();
        _isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search Watches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search watches...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResults.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          // Active Filters
          if (_selectedBrand != 'All' || _priceRange != const RangeValues(0, 10000))
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (_selectedBrand != 'All')
                    _buildFilterChip(
                      'Brand: $_selectedBrand',
                      () {
                        setState(() {
                          _selectedBrand = 'All';
                          _performSearch(_searchController.text);
                        });
                      },
                    ),
                  if (_priceRange != const RangeValues(0, 10000))
                    _buildFilterChip(
                      'Price: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                      () {
                        setState(() {
                          _priceRange = const RangeValues(0, 10000);
                          _performSearch(_searchController.text);
                        });
                      },
                    ),
                ],
              ),
            ),
          // Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDelete) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        deleteIcon: const Icon(Icons.close, size: 16),
        onDeleted: onDelete,
        backgroundColor: const Color(0xFF1a1a2e),
        labelStyle: const TextStyle(color: Colors.white),
        deleteIconColor: Colors.white,
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Search for your favorite watches',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No watches found',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try different keywords or filters',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return WatchCard(
          watch: _searchResults[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  watch: _searchResults[index],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setModalState(() {
                        _selectedBrand = 'All';
                        _priceRange = const RangeValues(0, 10000);
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Brand Filter
              Text(
                'Brand',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _brands.map((brand) {
                  final isSelected = brand == _selectedBrand;
                  return ChoiceChip(
                    label: Text(brand),
                    selected: isSelected,
                    onSelected: (selected) {
                      setModalState(() {
                        _selectedBrand = brand;
                      });
                    },
                    selectedColor: const Color(0xFF1a1a2e),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Price Range Filter
              Text(
                'Price Range',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${_priceRange.start.toInt()}',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    '\$${_priceRange.end.toInt()}',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 10000,
                divisions: 100,
                activeColor: const Color(0xFF1a1a2e),
                onChanged: (RangeValues values) {
                  setModalState(() {
                    _priceRange = values;
                  });
                },
              ),
              const SizedBox(height: 24),
              // Apply Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Apply filters
                    });
                    Navigator.pop(context);
                    _performSearch(_searchController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1a1a2e),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}