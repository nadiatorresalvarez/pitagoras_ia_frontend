import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_assets.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import 'models/onboarding_mock_data.dart';
import 'widgets/onboarding_scaffold.dart';
import 'widgets/onboarding_selection_card.dart';

class CareerPage extends StatefulWidget {
  const CareerPage({
    super.key,
    required this.universityId,
    required this.universityName,
    required this.areaId,
    required this.areaName,
  });

  final String universityId;
  final String universityName;
  final String areaId;
  final String areaName;

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  String? _selectedId = 'sistemas';

  String get _mascotMessage {
    final career = OnboardingMockData.careersForArea(widget.areaId)
        .where((item) => item.id == _selectedId)
        .firstOrNull;

    if (career == null) {
      return AppStrings.onboardingCareerMascotDefault;
    }

    return AppStrings.onboardingCareerMascot(career.name);
  }

  void _selectCareer(CareerOption career) {
    setState(() => _selectedId = career.id);

    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      context.push(
        RoutePaths.diagnosticPath(
          careerName: career.name,
          universityName: widget.universityName,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final careers = OnboardingMockData.careersForArea(widget.areaId);

    return OnboardingScaffold(
      bottomWidget: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.padding,
          0,
          AppSizes.padding,
          12,
        ),
        child: MascotConfirmationBubble(
          message: _mascotMessage,
          mascotAsset: AppAssets.mascotPose3,
        ),
      ),
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
            const OnboardingPageTitle(
              title: AppStrings.onboardingCareerTitle,
            ),
            const SizedBox(height: 14),
            SelectedAreaChip(areaName: widget.areaName),
            const SizedBox(height: 20),
            ...careers.map((career) {
              final isSelected = _selectedId == career.id;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OnboardingSelectionCard(
                  title: career.name,
                  subtitle: career.areaName,
                  scoreRange: career.scoreRange,
                  isSelected: isSelected,
                  onTap: () => _selectCareer(career),
                  leading: CareerIconAvatar(asset: career.iconAsset),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
