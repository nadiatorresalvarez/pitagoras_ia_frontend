import 'package:flutter/material.dart';

import '../../../core/constanst/app_assets.dart';
import '../../../core/constanst/app_sizes.dart';
import '../../../core/constanst/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../phone_page.dart';

class LoginBottomCard extends StatelessWidget {
  const LoginBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusCard),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A2F6BEE),
            blurRadius: 24,
            offset: Offset(0, -6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSizes.padding,
        28,
        AppSizes.padding,
        AppSizes.padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppStrings.loginTitle, style: AppTextStyles.cardTitle),
          const SizedBox(height: 6),
          Text(AppStrings.loginSubtitle, style: AppTextStyles.cardSubtitle),
          const SizedBox(height: 24),
          _GoogleButton(onPressed: () {}),
          const SizedBox(height: 18),
          const _OrDivider(),
          const SizedBox(height: 18),
          _PhoneButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const PhonePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusButton),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.googleIcon, height: 22, width: 22),
            const SizedBox(width: 12),
            Text(
              AppStrings.continueWithGoogle,
              style: AppTextStyles.buttonDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneButton extends StatelessWidget {
  const _PhoneButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusButton),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.phoneIcon,
              height: 20,
              width: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              AppStrings.continueWithPhone,
              style: AppTextStyles.buttonLight,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            AppStrings.orContinueWith,
            style: AppTextStyles.divider,
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider, height: 1)),
      ],
    );
  }
}
