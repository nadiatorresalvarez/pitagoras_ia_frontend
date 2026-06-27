import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'models/onboarding_mock_data.dart';
import 'widgets/onboarding_scaffold.dart';
import 'widgets/onboarding_selection_card.dart';

class AreaPage extends StatefulWidget {
  const AreaPage({
    super.key,
    required this.universityId,
    required this.universityName,
  });

  final String universityId;
  final String universityName;

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  String? _selectedId;

  void _selectArea(AreaOption area) {
    setState(() => _selectedId = area.id);

    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      context.push(
        RoutePaths.onboardingCareerPath(
          universityId: widget.universityId,
          universityName: widget.universityName,
          areaId: area.id,
          areaName: area.title,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.padding,
          8,
          AppSizes.padding,
          AppSizes.padding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnboardingPageTitle(
              title: AppStrings.onboardingAreaTitle(widget.universityName),
              subtitle: AppStrings.onboardingAreaSubtitle,
            ),
            const SizedBox(height: 20),
            ...OnboardingMockData.areas.map((area) {
              final isSelected = _selectedId == area.id;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OnboardingSelectionCard(
                  title: area.title,
                  subtitle: area.description,
                  isSelected: isSelected,
                  onTap: () => _selectArea(area),
                  leading: AreaIconAvatar(asset: area.iconAsset),
                ),
              );
            }),
            const SizedBox(height: 8),
            const VocationalWarningBanner(),
            const SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.open_in_new_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                label: Text(
                  AppStrings.onboardingNotSureYet,
                  style: AppTextStyles.linkAction,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
