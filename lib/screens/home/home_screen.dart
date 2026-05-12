import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/watch_model.dart';
import '../product/product_detail_screen.dart';
import '../search/search_screen.dart';
import '../../widgets/watch_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;
  String _selectedCategory = 'All';

  final List<String> _bannerImages = [
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
    'https://images.unsplash.com/photo-1587836374455-c4b1d5b9f906?w=800',
    'https://images.unsplash.com/photo-1611881263478-775a4e6f0d3e?w=800',
  ];

  final List<String> _categories = [
    'All',
    'Luxury',
    'Sports',
    'Smart',
    'Classic',
    'Casual',
  ];

  final List<WatchModel> _dummyWatches = [
    WatchModel(
      id: '1',
      name: 'Rolex Submariner',
      brand: 'Rolex',
      price: 8950.00,
      description: 'Iconic dive watch with water resistance up to 300 meters',
      images: [
        'https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?w=500',
        'https://images.unsplash.com/photo-1587836374455-c4b1d5b9f906?w=500',
      ],
      category: 'Luxury',
      stock: 5,
      rating: 4.8,
      reviewCount: 124,
      specifications: {
        'Movement': 'Automatic',
        'Case Size': '41mm',
        'Water Resistance': '300m',
        'Material': 'Stainless Steel',
      },
    ),
    WatchModel(
      id: '2',
      name: 'Apple Watch Series 9',
      brand: 'Apple',
      price: 399.00,
      description: 'Advanced smartwatch with health tracking features',
      images: [
        'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500',
        'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500',
      ],
      category: 'Smart',
      stock: 20,
      rating: 4.6,
      reviewCount: 856,
      specifications: {
        'Display': 'OLED Retina',
        'Case Size': '45mm',
        'Battery': '18 hours',
        'Water Resistance': '50m',
      },
    ),
    WatchModel(
      id: '3',
      name: 'Omega Speedmaster',
      brand: 'Omega',
      price: 6500.00,
      description: 'Legendary moonwatch with chronograph function',
      images: [
        'https://images.unsplash.com/photo-1611881263478-775a4e6f0d3e?w=500',
        'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=500',
      ],
      category: 'Luxury',
      stock: 8,
      rating: 4.9,
      reviewCount: 234,
      specifications: {
        'Movement': 'Manual',
        'Case Size': '42mm',
        'Water Resistance': '50m',
        'Material': 'Stainless Steel',
      },
    ),
    WatchModel(
      id: '4',
      name: 'TAG Heuer Carrera',
      brand: 'TAG Heuer',
      price: 4200.00,
      description: 'Racing-inspired chronograph with sporty design',
      images: [
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
        'https://images.unsplash.com/photo-1509048191080-d2984bad6ae5?w=500',
      ],
      category: 'Sports',
      stock: 12,
      rating: 4.7,
      reviewCount: 189,
      specifications: {
        'Movement': 'Automatic',
        'Case Size': '43mm',
        'Water Resistance': '100m',
        'Material': 'Stainless Steel',
      },
    ),
    WatchModel(
      id: '5',
      name: 'Seiko Presage',
      brand: 'Seiko',
      price: 450.00,
      description: 'Elegant dress watch with automatic movement',
      images: [
        'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=500',
        'https://images.unsplash.com/photo-1533139502658-0198f920d8e8?w=500',
      ],
      category: 'Classic',
      stock: 15,
      rating: 4.5,
      reviewCount: 312,
      specifications: {
        'Movement': 'Automatic',
        'Case Size': '40mm',
        'Water Resistance': '50m',
        'Material': 'Stainless Steel',
      },
    ),
  ];

  List<WatchModel> get _filteredWatches {
    if (_selectedCategory == 'All') {
      return _dummyWatches;
    }
    return _dummyWatches
        .where((watch) => watch.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.watch, color: Color(0xFF1a1a2e), size: 28),
            const SizedBox(width: 8),
            Text(
              'WatchHub',
              style: GoogleFonts.poppins(
                color: const Color(0xFF1a1a2e),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Carousel
            _buildBannerCarousel(),
            const SizedBox(height: 20),
            // Categories
            _buildCategories(),
            const SizedBox(height: 20),
            // Featured Section
            _buildSectionHeader('Featured Watches', onSeeAll: () {}),
            const SizedBox(height: 12),
            _buildFeaturedWatches(),
            const SizedBox(height: 20),
            // Popular Section
            _buildSectionHeader('Popular Watches', onSeeAll: () {}),
            const SizedBox(height: 12),
            _buildPopularWatches(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
          items: _bannerImages.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Premium Collection',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Up to 30% OFF',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _currentBannerIndex,
          count: _bannerImages.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: const Color(0xFF1a1a2e),
            dotColor: Colors.grey[300]!,
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1a1a2e)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1a1a2e)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  category,
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1a1a2e),
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'See All',
              style: GoogleFonts.poppins(
                color: const Color(0xFF1a1a2e),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedWatches() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filteredWatches.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 180,
              child: WatchCard(
                watch: _filteredWatches[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        watch: _filteredWatches[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularWatches() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredWatches.length > 3 ? 3 : _filteredWatches.length,
      itemBuilder: (context, index) {
        final watch = _filteredWatches[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildHorizontalWatchCard(watch),
        );
      },
    );
  }

  Widget _buildHorizontalWatchCard(WatchModel watch) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(watch: watch),
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage(watch.images.first),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          watch.brand,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          watch.name,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1a1a2e),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${watch.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1a1a2e),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              watch.rating.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}