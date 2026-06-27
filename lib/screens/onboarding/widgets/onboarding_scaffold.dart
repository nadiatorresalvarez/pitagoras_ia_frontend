import 'package:flutter/material.dart';

import '../../../core/constanst/app_assets.dart';
import '../../../core/constanst/app_sizes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.body,
    this.onBack,
    this.showBackButton = true,
    this.bottomWidget,
  });

  final Widget body;
  final VoidCallback? onBack;
  final bool showBackButton;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: showBackButton
            ? IconButton(
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.navy,
                  size: 20,
                ),
              )
            : null,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('PITÁGORAS ', style: AppTextStyles.appName),
            Text('IA', style: AppTextStyles.appNameAccent),
          ],
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.navy,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: body),
          if (bottomWidget != null) bottomWidget!,
          const _OnboardingBottomNav(),
        ],
      ),
    );
  }
}

class _OnboardingBottomNav extends StatelessWidget {
  const _OnboardingBottomNav();

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItem(label: 'Inicio', asset: AppAssets.iconHome, selected: true),
      _NavItem(label: 'Estudiar', asset: AppAssets.iconStudy),
      _NavItem(label: 'Evaluaciones', asset: AppAssets.iconEvaluations),
      _NavItem(label: 'Ranking', asset: AppAssets.iconRanking),
      _NavItem(label: 'Perfil', asset: AppAssets.iconProfile),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: items
              .map(
                (item) => Expanded(
                  child: _BottomNavItem(item: item),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.asset,
    this.selected = false,
  });

  final String label;
  final String asset;
  final bool selected;
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.item});

  final _NavItem item;

  @override
  Widget build(BuildContext context) {
    final color = item.selected ? AppColors.primary : AppColors.textMuted;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          item.asset,
          width: 22,
          height: 22,
          color: color,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(height: 4),
        Text(
          item.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: item.selected ? FontWeight.w600 : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}

class OnboardingPageTitle extends StatelessWidget {
  const OnboardingPageTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.onboardingTitle,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: AppTextStyles.onboardingSubtitle),
        ],
      ],
    );
  }
}

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key, this.location = 'Arequipa'});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusSelectionCard),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              location,
              style: AppTextStyles.selectionTitle,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
