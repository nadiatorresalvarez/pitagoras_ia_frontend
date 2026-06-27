import 'package:flutter/material.dart';

import '../../../core/constanst/app_assets.dart';
import '../../../core/constanst/app_sizes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/diagnostic_mock_data.dart';

class DiagnosticScaffold extends StatelessWidget {
  const DiagnosticScaffold({
    super.key,
    required this.body,
    this.title,
    this.subtitle,
    this.onBack,
    this.bottomBar,
    this.showBottomNav = true,
  });

  final Widget body;
  final String? title;
  final String? subtitle;
  final VoidCallback? onBack;
  final Widget? bottomBar;
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.navy,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: title == null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('PITÁGORAS ', style: AppTextStyles.appName),
                  Text('IA', style: AppTextStyles.appNameAccent),
                ],
              )
            : Column(
                children: [
                  Text(title!, style: AppTextStyles.diagnosticAppBarTitle),
                  if (subtitle != null)
                    Text(subtitle!, style: AppTextStyles.diagnosticAppBarSub),
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
          if (bottomBar != null) bottomBar!,
          if (showBottomNav) const _DiagnosticBottomNav(),
        ],
      ),
    );
  }
}

class _DiagnosticBottomNav extends StatelessWidget {
  const _DiagnosticBottomNav();

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
              .map((item) => Expanded(child: _BottomNavItem(item: item)))
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

class DiagnosticInfoRow extends StatelessWidget {
  const DiagnosticInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.diagnosticCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.selectionTitle),
                Text(subtitle, style: AppTextStyles.selectionSubtitle),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class DiagnosticAreaProgressRow extends StatelessWidget {
  const DiagnosticAreaProgressRow({
    super.key,
    required this.name,
    required this.iconAsset,
    required this.percent,
    this.isProcessing = false,
    this.showPercentLabel = false,
  });

  final String name;
  final String iconAsset;
  final double percent;
  final bool isProcessing;
  final bool showPercentLabel;

  @override
  Widget build(BuildContext context) {
    final barColor = isProcessing
        ? AppColors.border
        : DiagnosticMockData.progressColor(percent);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Image.asset(iconAsset, width: 22, height: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name, style: AppTextStyles.selectionTitle),
                    ),
                    if (showPercentLabel)
                      Text(
                        '${(percent * 100).round()}%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: barColor,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: isProcessing ? null : percent,
                    minHeight: 6,
                    backgroundColor: AppColors.border,
                    color: barColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (isProcessing)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            )
          else
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 22,
            ),
        ],
      ),
    );
  }
}
