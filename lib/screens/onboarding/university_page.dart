import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import 'models/onboarding_mock_data.dart';
import 'widgets/onboarding_scaffold.dart';
import 'widgets/onboarding_selection_card.dart';

class UniversityPage extends StatefulWidget {
  const UniversityPage({super.key});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  String? _selectedId = 'unsa';

  void _selectUniversity(UniversityOption university) {
    setState(() => _selectedId = university.id);

    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      context.push(
        RoutePaths.onboardingAreaPath(
          universityId: university.id,
          universityName: university.acronym,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      showBackButton: true,
      onBack: () => context.go(RoutePaths.login),
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
              title: AppStrings.onboardingUniversityTitle,
            ),
            const SizedBox(height: 20),
            const LocationSelector(),
            const SizedBox(height: 20),
            ...OnboardingMockData.universities.map((university) {
              final isSelected = _selectedId == university.id;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OnboardingSelectionCard(
                  title: university.acronym,
                  subtitle: university.fullName,
                  isSelected: isSelected,
                  onTap: () => _selectUniversity(university),
                  leading: UniversityLogoAvatar(
                    logoAsset: university.logoAsset,
                    initials: university.initials,
                    initialsColor: university.initialsColor,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
