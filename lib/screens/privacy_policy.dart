import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle headingStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    TextStyle sectionTitleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.deepPurple,
    );

    TextStyle paragraphStyle = const TextStyle(
      fontSize: 14,
      height: 1.6,
      color: Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Privacy Policy for Blogify", style: headingStyle),
              const SizedBox(height: 8),
              Text("Effective Date: 21 June, 2025", style: paragraphStyle),
              const SizedBox(height: 16),
              Text("Welcome to Blogify!", style: sectionTitleStyle),
              Text(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our application and related services.",
                style: paragraphStyle,
              ),
              const SizedBox(height: 20),
              Text("1. Information We Collect", style: sectionTitleStyle),
              Text("a. Personal Information", style: paragraphStyle),
              bulletPoints([
                "Name",
                "Email address",
                "Username",
                "Profile photo (optional)",
              ]),
              Text("b. Content Data", style: paragraphStyle),
              bulletPoints([
                "Posts you write",
                "Comments you make",
                "Categories or tags you select",
              ]),
              Text("c. Usage Data", style: paragraphStyle),
              bulletPoints([
                "Device information",
                "IP address",
                "Browser type",
                "App usage logs and analytics",
              ]),
              Text("d. Cookies & Local Storage", style: paragraphStyle),
              Text(
                "We may use cookies or similar technologies to improve your experience (e.g., keeping you logged in or saving preferences).",
                style: paragraphStyle,
              ),
              const SizedBox(height: 20),
              Text("2. How We Use Your Information", style: sectionTitleStyle),
              bulletPoints([
                "Create and manage your account",
                "Publish and display blog content",
                "Respond to support inquiries",
                "Analyze app performance and user behavior",
                "Improve features and user experience",
                "Prevent fraud or abuse",
              ]),
              const SizedBox(height: 20),
              Text("3. How We Share Your Information",
                  style: sectionTitleStyle),
              Text("We do not sell or rent your personal information.",
                  style: paragraphStyle),
              bulletPoints([
                "Service Providers (e.g., analytics, hosting)",
                "Legal Authorities (if required to comply with law or protect rights)",
                "Other Users (only the content you choose to publish)",
              ]),
              const SizedBox(height: 20),
              Text("4. Your Choices", style: sectionTitleStyle),
              bulletPoints([
                "Edit or delete your profile and posts",
                "Opt-out of email notifications",
                "Request deletion of your account by contacting us at [insert contact email]",
              ]),
              const SizedBox(height: 20),
              Text("5. Data Security", style: sectionTitleStyle),
              bulletPoints([
                "Encryption",
                "Authentication checks",
                "Secure servers",
              ]),
              Text(
                "However, no system is 100% secure, and we encourage you to use strong passwords and keep your login credentials confidential.",
                style: paragraphStyle,
              ),
              const SizedBox(height: 20),
              Text("6. Children's Privacy", style: sectionTitleStyle),
              Text(
                "Blogify is not intended for users under the age of 13. We do not knowingly collect data from children. If you believe we’ve collected data from a minor, please contact us immediately.",
                style: paragraphStyle,
              ),
              const SizedBox(height: 20),
              Text("7. Changes to This Policy", style: sectionTitleStyle),
              Text(
                "We may update this Privacy Policy from time to time. When we do, we will notify you via the app or email. Continued use of Blogify means you agree to the updated terms.",
                style: paragraphStyle,
              ),
              const SizedBox(height: 20),
              Text("8. Contact Us", style: sectionTitleStyle),
              Text(
                "If you have questions or concerns about this Privacy Policy, please reach out to us at:\n\n📧 BlogifySupport@gmail.com\n📱 Blogify Support Team",
                style: paragraphStyle,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper to render bullet points
  Widget bulletPoints(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 4.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("•  ", style: TextStyle(fontSize: 14)),
                    Expanded(
                        child:
                            Text(item, style: const TextStyle(fontSize: 14))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
