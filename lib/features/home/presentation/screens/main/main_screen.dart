import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../widgets/organic_field_widget.dart';
import '../../providers/home_provider.dart';
import 'package:habit_tracker_challenge/features/challenges/presentation/screens/challenge_list_screen.dart';
import '../../../../challenges/presentation/screens/my_land_screen.dart';

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
  final GlobalKey _myLandKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Get data
    _fieldItems = HomeProvider().generateFieldItems();

    _transformationController = TransformationController();

    // Set initial position to center "My Land" after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerOnMyLand();
    });
  }

  void _centerOnMyLand() {
    final RenderBox? renderBox =
        _myLandKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Canvas is 4x screen size. Center of canvas is (2W, 2H).
    // "My Land" is likely near the center.
    // To center (2W, 2H) on screen (0.5W, 0.5H) with Scale 1.0:
    // Translation = ScreenCenter - ContentCenter = (0.5W, 0.5H) - (2W, 2H) = (-1.5W, -1.5H).

    final matrix = Matrix4.identity()
      ..translate(-screenWidth * 1.5, -screenHeight * 1.5)
      ..scale(1.0); // Normal zoom

    _transformationController.value = matrix;
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
                        color: Colors.black.withValues(alpha: 0.1),
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

          // 3. Recenter Button (Bottom Right)
          if (_isMapView)
            Positioned(
              bottom: 100,
              right: 20,
              child: FloatingActionButton(
                heroTag: 'recenter_map',
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.center_focus_strong,
                  color: Colors.black87,
                ),
                onPressed: _centerOnMyLand,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMapView(double screenWidth, double screenHeight) {
    return InteractiveViewer(
      transformationController: _transformationController,
      boundaryMargin: const EdgeInsets.symmetric(
        horizontal: 2000,
        vertical: 2000,
      ),
      minScale: 0.1,
      maxScale: 4.0,
      constrained: false, // Allows the child to be infinite
      child: Padding(
        padding: const EdgeInsets.all(50.0), // Padding around the grid
        child: SizedBox(
          width: screenWidth * 4,

          // Remove fixed height - let the grid determine it primarily, or keep it large if needed.
          // StaggeredGrid needs a constrained width (provided by SizedBox) but height can be intrinsic.
          // However, for InteractiveViewer, having a known size helps.
          // Let's keep width constrained and allow height to flow or be large enough.
          child: StaggeredGrid.count(
            crossAxisCount: 6, // Increased column count for finer control
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: _fieldItems.map((item) {
              final isSelected = _selectedFields.contains(item.id);
              // Adjust cell count logic if we increased crossAxisCount from 4 to 6
              // Old: 4 cols. New: 6 cols. 1.5x factor.

              int crossCount = item.crossAxisCellCount;
              int mainCount = item.mainAxisCellCount;

              // Adjust for "My Land" - make it prominent
              if (item.id == 999) {
                return StaggeredGridTile.count(
                  crossAxisCellCount: 4, // 4/6 width
                  mainAxisCellCount: 3,
                  child: OrganicFieldWidget(
                    key: _myLandKey,
                    fieldItem: item,
                    isSelected: isSelected,
                    onTap: () => _handleFieldTap(item),
                  ),
                );
              }

              // Adjust others mostly to 2 or 3 cols
              return StaggeredGridTile.count(
                crossAxisCellCount: crossCount == 2
                    ? 3
                    : (crossCount == 1 ? 2 : crossCount),
                mainAxisCellCount: mainCount,
                child: OrganicFieldWidget(
                  fieldItem: item,
                  isSelected: isSelected,
                  onTap: () => _handleFieldTap(item),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _handleFieldTap(FieldItem item) {
    if (item.id == 999) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyLandScreen()),
      );
    } else if (item.category != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChallengeListScreen(category: item.category!),
        ),
      );
    } else {
      setState(() {
        if (_selectedFields.contains(item.id)) {
          _selectedFields.remove(item.id);
        } else {
          _selectedFields.add(item.id);
        }
      });
    }
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 160,
        left: 16,
        right: 16,
        bottom: 120,
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
                  color: Colors.black.withValues(alpha: 0.05),
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
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26F05F).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item.icon,
                      color: const Color(0xFF1A1A1A),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
