import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Detail Product',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Product Image
                  Center(
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Color Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorOption(Colors.black, true),
                      _buildColorOption(Colors.blue, false),
                      _buildColorOption(Colors.grey, false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Info
                  const Text(
                    'NBA Shoes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Men Wonder-13 Sports Shoes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '\$449.00',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '\$699.00',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Size Options
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Size',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSizeOption('6 UK', true),
                      _buildSizeOption('8 UK', false),
                      _buildSizeOption('10 UK', false),
                      _buildSizeOption('11 UK', false),
                      _buildSizeOption('12 UK', false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Height increasing non-marking EVA sole made with light weight compound and orthopedic memory foam shoes which provides extra comfort to your feet.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Related Products Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Related Products',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildRelatedProducts(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Review Section
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Reviews',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildReviewSection(),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Total Price :',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$119.00',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'BUY NOW',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () {},
                      child: const Icon(Icons.lock, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
      ),
    );
  }

  Widget _buildSizeOption(String size, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Handle size selection
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.white,
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    final List<Map<String, dynamic>> reviews = [
      {'name': 'John Doe', 'rating': 5, 'feedback': 'Great product!'},
      {'name': 'Jane Smith', 'rating': 4, 'feedback': 'Very comfortable.'},
    ];

    return Column(
      children: reviews.map((review) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  review['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                _buildStarRating(review['rating']),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              review['feedback'],
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 20,
        );
      }),
    );
  }

  List<Widget> _buildRelatedProducts() {
    final List<Map<String, String>> products = [
      {'name': 'Shoe 1', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Shoe 2', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Shoe 3', 'image': 'https://via.placeholder.com/150'},
    ];

    return products
        .map((product) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    product['image']!,
                    height: 100,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['name']!,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ))
        .toList();
  }
}
