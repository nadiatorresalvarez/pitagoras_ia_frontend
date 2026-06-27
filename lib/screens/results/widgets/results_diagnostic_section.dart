import 'package:flutter/material.dart';

import '../../../core/constanst/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/enums.dart';
import '../../../data/models/diagnostic_model.dart';
import 'results_section_header.dart';

/// Diagnóstico (`GET /diagnostics/student-exams/{id}`).
class ResultsDiagnosticSection extends StatelessWidget {
  const ResultsDiagnosticSection({super.key, required this.report});

  final DiagnosticReport report;

  Color _levelColor(PerformanceLevel level) {
    switch (level) {
      case PerformanceLevel.strength:
        return const Color(0xFF16A34A);
      case PerformanceLevel.weakness:
        return const Color(0xFFEA580C);
      case PerformanceLevel.neutral:
        return const Color(0xFFD97706);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ResultsSectionHeader(title: AppStrings.resultsDiagnosticSection),
        const SizedBox(height: 16),
        _BulletList(
          title: AppStrings.resultsStrengths,
          items: report.strengths,
          icon: Icons.trending_up,
          color: const Color(0xFF16A34A),
        ),
        const SizedBox(height: 16),
        _BulletList(
          title: AppStrings.resultsWeaknesses,
          items: report.weaknesses,
          icon: Icons.trending_down,
          color: const Color(0xFFEA580C),
        ),
        if (report.areas.isNotEmpty) ...[
          const SizedBox(height: 20),
          ...report.areas.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _DiagnosticTile(
                name: item.name,
                scorePercent: item.scorePercent,
                detail: '${item.correctAnswers}/${item.totalQuestions}',
                levelColor: _levelColor(item.level),
                levelLabel: item.level.value,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({
    required this.title,
    required this.items,
    required this.icon,
    required this.color,
  });

  final String title;
  final List<String> items;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(title, style: AppTextStyles.cardTitle.copyWith(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        if (items.isEmpty)
          Text(AppStrings.resultsNoData, style: AppTextStyles.cardSubtitle)
        else
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 4),
              child: Text('• $item', style: AppTextStyles.welcome),
            ),
          ),
      ],
    );
  }
}

class _DiagnosticTile extends StatelessWidget {
  const _DiagnosticTile({
    required this.name,
    required this.scorePercent,
    required this.detail,
    required this.levelColor,
    required this.levelLabel,
  });

  final String name;
  final double scorePercent;
  final String detail;
  final Color levelColor;
  final String levelLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.cardSubtitle),
                Text(
                  '$detail · ${scorePercent.toStringAsFixed(0)}%',
                  style: AppTextStyles.cardSubtitle.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: levelColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              levelLabel,
              style: TextStyle(color: levelColor, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
