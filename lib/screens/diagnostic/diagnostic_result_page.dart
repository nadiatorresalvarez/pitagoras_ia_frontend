import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constanst/app_assets.dart';
import '../../core/constanst/app_sizes.dart';
import '../../core/constanst/app_strings.dart';
import '../../core/router/route_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'models/diagnostic_mock_data.dart';
import 'widgets/diagnostic_scaffold.dart';
import 'widgets/diagnostic_widgets.dart';

class DiagnosticResultPage extends StatelessWidget {
  const DiagnosticResultPage({
    super.key,
    required this.careerName,
    required this.universityName,
  });

  final String careerName;
  final String universityName;

  @override
  Widget build(BuildContext context) {
    final subtitle = '$careerName - $universityName';

    return DiagnosticScaffold(
      title: AppStrings.diagnosticResultTitle,
      subtitle: subtitle,
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
              padding: const EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.diagnosticYourScore,
                          style: AppTextStyles.selectionSubtitle,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${DiagnosticMockData.obtainedScore.toStringAsFixed(1)} / 100',
                          style: AppTextStyles.diagnosticScoreBig,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.successLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.arrow_upward_rounded,
                                size: 14,
                                color: AppColors.success,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AppStrings.diagnosticInZone,
                                style: AppTextStyles.chipLabel.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    AppAssets.iconTrophy,
                    width: 72,
                    height: 72,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            DiagnosticScoreGauge(
              score: DiagnosticMockData.obtainedScore,
              minScore: DiagnosticMockData.minHistorical,
              maxScore: DiagnosticMockData.maxHistorical,
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.diagnosticPerformanceByArea,
              style: AppTextStyles.selectionTitle,
            ),
            const SizedBox(height: 16),
            ...DiagnosticMockData.resultAreas.map(
              (area) => DiagnosticAreaProgressRow(
                name: area.name,
                iconAsset: area.iconAsset,
                percent: area.percent,
                showPercentLabel: true,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  context.push(
                    RoutePaths.diagnosticRecommendationsPath(
                      careerName: careerName,
                      universityName: universityName,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusButton),
                  ),
                ),
                child: Text(
                  AppStrings.diagnosticViewRecommendations,
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
