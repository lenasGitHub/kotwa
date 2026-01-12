import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../widgets/organic_field_widget.dart';
import '../../providers/home_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Track selected field IDs
  final Set<int> _selectedFields = {};

  // View State
  bool _isMapView = true;

  // Data
  late List<FieldItem> _fieldItems;

  // Map Controller
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    // Get data
    _fieldItems = HomeProvider().generateFieldItems();

    _transformationController = TransformationController();

    // Set initial position to center after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      // Calculate center position
      final canvasWidth = screenWidth * 4;
      final canvasHeight = screenHeight * 4;

      final x = -(canvasWidth - screenWidth) / 2;
      final y = -(canvasHeight - screenHeight) / 2;

      _transformationController.value = Matrix4.identity()..translate(x, y);
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen size for Map calculations
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFFF8F5F2), // Light beige background
      child: Stack(
        children: [
          // 1. Content Layer (Map or List)
          Positioned.fill(
            child: _isMapView
                ? _buildMapView(screenWidth, screenHeight)
                : _buildListView(),
          ),

          // 2. Top Stats Header Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF26F05F),
                            width: 3,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://i.pravatar.cc/100?img=68',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Stats Row
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Betterflies
                            Row(
                              children: [
                                const Icon(
                                  Icons.filter_vintage,
                                  color: Color(0xFF26F05F),
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: '240',
                                        style: TextStyle(
                                          color: Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '/300',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Hearts
                            Row(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Color(0xFFFF80EA),
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '54',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),

                            // Protection Balance
                            Row(
                              children: [
                                const Icon(
                                  Icons.security,
                                  color: Color(0xFF40E0D0),
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '\$4.2k',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Hamburger Menu
                      const Icon(
                        Icons.menu,
                        color: Color(0xFF1A1A1A),
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Map/List Toggle Header (Specific to Main Screen)
          // Positioned(
          //   top: 90,
          //   left: 16,
          //   right: 16,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       // Row 1: Map/List Toggle + Search
          //       Row(
          //         children: [
          //           // Map/List Toggle
          //           Container(
          //             height: 56,
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(28),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 10,
          //                   offset: const Offset(0, 2),
          //                 ),
          //               ],
          //             ),
          //             child: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 // Map Button
          //                 GestureDetector(
          //                   onTap: () => setState(() => _isMapView = true),
          //                   child: Container(
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 24,
          //                       vertical: 12,
          //                     ),
          //                     decoration: BoxDecoration(
          //                       color: _isMapView
          //                           ? const Color(0xFF1A2C2C)
          //                           : Colors.transparent,
          //                       borderRadius: BorderRadius.circular(28),
          //                     ),
          //                     child: Row(
          //                       children: [
          //                         Icon(
          //                           Icons.map_outlined,
          //                           color: _isMapView
          //                               ? Colors.white
          //                               : const Color(0xFF1A2C2C),
          //                           size: 20,
          //                         ),
          //                         const SizedBox(width: 8),
          //                         Text(
          //                           'Map',
          //                           style: GoogleFonts.cairo(
          //                             color: _isMapView
          //                                 ? Colors.white
          //                                 : const Color(0xFF1A2C2C),
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.w600,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 // List Button
          //                 GestureDetector(
          //                   onTap: () => setState(() => _isMapView = false),
          //                   child: Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 24,
          //                       vertical: 12,
          //                     ),
          //                     child: Row(
          //                       children: [
          //                         Icon(
          //                           Icons.view_list_rounded,
          //                           color: !_isMapView
          //                               ? Colors.white
          //                               : const Color(0xFF1A2C2C),
          //                           size: 20,
          //                         ),
          //                         const SizedBox(width: 8),
          //                         Text(
          //                           'List',
          //                           style: GoogleFonts.cairo(
          //                             color: !_isMapView
          //                                 ? Colors.white
          //                                 : const Color(0xFF1A2C2C),
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.w600,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const Spacer(),
          //           // Search Button
          //           Container(
          //             width: 56,
          //             height: 56,
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               shape: BoxShape.circle,
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.1),
          //                   blurRadius: 10,
          //                   offset: const Offset(0, 2),
          //                 ),
          //               ],
          //             ),
          //             child: const Icon(
          //               Icons.search,
          //               color: Color(0xFF1A2C2C),
          //               size: 24,
          //             ),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 12),
          //       // Row 2: Filter Chips
          //       SizedBox(
          //         height: 36,
          //         child: ListView(
          //           scrollDirection: Axis.horizontal,
          //           children: [
          //             _buildFilterChip('Harvest Soon'),
          //             const SizedBox(width: 8),
          //             _buildFilterChip('Needs Watering'),
          //             const SizedBox(width: 8),
          //             _buildFilterChip('Potential Issues'),
          //             const SizedBox(width: 8),
          //             _buildFilterChip('Needs Watering'),
          //             const SizedBox(width: 8),
          //             _buildFilterChip('Potential Issues'),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildMapView(double screenWidth, double screenHeight) {
    return InteractiveViewer(
      transformationController: _transformationController,
      boundaryMargin: const EdgeInsets.fromLTRB(40, 100, 40, 40),
      minScale: 0.3,
      maxScale: 0.3,
      constrained: false,
      panEnabled: true,
      scaleEnabled: false,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: screenWidth * 4,
          height: screenHeight * 4,
          child: MasonryGridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: _fieldItems.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = _fieldItems[index];
              final isSelected = _selectedFields.contains(item.id);

              return OrganicFieldWidget(
                fieldItem: item,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    if (_selectedFields.contains(item.id)) {
                      _selectedFields.remove(item.id);
                    } else {
                      _selectedFields.add(item.id);
                    }
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 160, // Space for header
        left: 16,
        right: 16,
        bottom: 120, // Space for bottom nav
      ),
      child: ListView.builder(
        itemCount: _fieldItems.length,
        itemBuilder: (context, index) {
          final item = _fieldItems[index];
          final isSelected = _selectedFields.contains(item.id);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF26F05F)
                    : Colors.grey.shade200,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_selectedFields.contains(item.id)) {
                    _selectedFields.remove(item.id);
                  } else {
                    _selectedFields.add(item.id);
                  }
                });
              },
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26F05F).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item.icon,
                      color: const Color(0xFF1A1A1A),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF666666),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Pin indicators
                  if (item.pins.isNotEmpty)
                    Row(
                      children: [
                        ...item.pins
                            .take(3)
                            .map(
                              (pin) => Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF26F05F),
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://i.pravatar.cc/150?img=${pin.avatarIndex + 1}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        if (item.pins.length > 3)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF26F05F),
                              ),
                              child: Center(
                                child: Text(
                                  '+${item.pins.length - 3}',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFF1A1A1A),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
