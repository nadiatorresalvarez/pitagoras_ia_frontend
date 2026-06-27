import 'package:flutter/material.dart';

import '../../core/constanst/app_assets.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'models/diagnostic_mock_data.dart';
import 'widgets/diagnostic_scaffold.dart';

class DiagnosticRecommendationsPage extends StatelessWidget {
  const DiagnosticRecommendationsPage({
    super.key,
    required this.careerName,
    required this.universityName,
  });

  final String careerName;
  final String universityName;

  @override
  Widget build(BuildContext context) {
    final strengths = DiagnosticMockData.strengths
        .where((item) => item.isStrength)
        .toList();
    final weaknesses = DiagnosticMockData.strengths
        .where((item) => !item.isStrength)
        .toList();

    return DiagnosticScaffold(
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.aiCardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.welcome,
                        children: [
                          TextSpan(
                            text: AppStrings.diagnosticAiHighlight,
                            style: AppTextStyles.selectionTitle,
                          ),
                          TextSpan(
                            text: AppStrings.diagnosticAiBody,
                            style: AppTextStyles.welcome,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    AppAssets.mascotIdea,
                    height: 72,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.diagnosticStrengths,
              style: AppTextStyles.selectionTitle.copyWith(
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 12),
            ...strengths.map(
              (item) => _StrengthWeaknessRow(
                name: item.name,
                isStrength: true,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.diagnosticWeaknesses,
              style: AppTextStyles.selectionTitle.copyWith(
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: 12),
            ...weaknesses.map(
              (item) => _StrengthWeaknessRow(
                name: item.name,
                isStrength: false,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusButton),
                  ),
                ),
                child: Text(
                  AppStrings.diagnosticCreatePlan,
                  style: AppTextStyles.buttonLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StrengthWeaknessRow extends StatelessWidget {
  const _StrengthWeaknessRow({
    required this.name,
    required this.isStrength,
  });

  final String name;
  final bool isStrength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            isStrength ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isStrength ? AppColors.success : AppColors.danger,
            size: 22,
          ),
          const SizedBox(width: 10),
          Text(name, style: AppTextStyles.selectionTitle),
        ],
      ),
    );
  }
}
