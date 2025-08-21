import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/provider/user_controller.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.maincolor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with menu and profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Utils.maincolor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(4.0, 4.0),
                        ),
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(-4.0, -4.0),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    foregroundImage: AssetImage('assets/profile.png'),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Profile Info Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Utils.maincolor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(4.0, 4.0),
                    ),
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(-4.0, -4.0),
                    ),
                  ],
                ),
                child: Consumer<UserController>(
                  builder: (context, controller, child) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          foregroundImage: AssetImage('assets/profile.png'),
                        ),
                        SizedBox(height: 16),
                        Text(
                          controller.isLoading
                              ? 'Loading...'
                              : controller.user.fullName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          controller.isLoading
                              ? 'Loading...'
                              : controller.user.email,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4FD1C7),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4FD1C7).withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Premium Member',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 30),

              // Stats Section
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Orders', '24', Icons.shopping_bag),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard('Wishlist', '12', Icons.favorite),
                  ),
                  SizedBox(width: 15),
                  Expanded(child: _buildStatCard('Reviews', '8', Icons.star)),
                ],
              ),

              SizedBox(height: 30),

              // Menu Options
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 16),

              _buildMenuOption('Edit Profile', Icons.person_outline, () {}),
              _buildMenuOption('Order History', Icons.history, () {}),
              _buildMenuOption('Payment Methods', Icons.payment, () {}),
              _buildMenuOption(
                'Shipping Address',
                Icons.location_on_outlined,
                () {},
              ),

              SizedBox(height: 20),

              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 16),

              _buildMenuOption(
                'Notifications',
                Icons.notifications_outlined,
                () {},
              ),
              _buildMenuOption('Privacy & Security', Icons.security, () {}),
              _buildMenuOption('Help & Support', Icons.help_outline, () {}),

              SizedBox(height: 30),

              // Logout Button
              Consumer<UserController>(
                builder: (context, controller, child) {
                  return Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.signOut(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withValues(alpha: 0.2),
                        foregroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.red.withOpacity(0.3)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Utils.maincolor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 1,
            offset: Offset(4.0, 4.0),
          ),
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 1,
            offset: Offset(-4.0, -4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF4FD1C7), size: 28),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
        ],
      ),
    );
  }

  Widget _buildMenuOption(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Utils.maincolor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(4.0, 4.0),
              ),
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(-4.0, -4.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF4FD1C7).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Color(0xFF4FD1C7), size: 20),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
