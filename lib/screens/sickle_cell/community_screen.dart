import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Support')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                const Icon(FeatherIcons.shield, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'All interactions are strictly moderated by AI to ensure safety and accurate health discussions.',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildPostCard(
            context,
            author: 'AnonymousWarrior',
            time: '2 hours ago',
            content:
                'Has anyone found a reliable way to manage fatigue during exams? I am really struggling this week.',
            tags: ['Fatigue', 'School'],
            likes: 12,
            comments: 4,
          ),
          const SizedBox(height: 16),
          _buildPostCard(
            context,
            author: 'Jane_D',
            time: '5 hours ago',
            content:
                'Just left the clinic, my hematologist mentioned a new hydroxyurea protocol. I documented my journey if anyone is interested.',
            tags: ['Medication', 'Journey'],
            likes: 34,
            comments: 11,
            isVerified: true,
          ),
          const SizedBox(height: 16),
          _buildPostCard(
            context,
            author: 'Mark22',
            time: '1 day ago',
            content:
                'Remember to stay hydrated! I set alarms every hour. It really helps prevent crisis triggers when it gets hot.',
            tags: ['Tips', 'Prevention'],
            likes: 45,
            comments: 2,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(FeatherIcons.edit2, color: Colors.white),
      ),
    );
  }

  Widget _buildPostCard(
    BuildContext context, {
    required String author,
    required String time,
    required String content,
    required List<String> tags,
    required int likes,
    required int comments,
    bool isVerified = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.surface,
                child: Text(
                  author[0],
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ],
                    ],
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: tags.map((tag) {
              return Text(
                '#$tag',
                style: const TextStyle(color: AppColors.primary, fontSize: 13),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    FeatherIcons.heart,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$likes',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    FeatherIcons.messageCircle,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$comments',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Icon(
                FeatherIcons.share2,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
