import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Welcome,")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                                Text("Enterprise Admin")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Image(systemName: "bell.badge")
                                .padding(12)
                                .background(AppTheme.cardBackground)
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        
                        // Status Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("System Status")
                                    .font(.headline)
                                Spacer()
                                Text("Secure")
                                    .font(.caption.bold())
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.green)
                                    .clipShape(Capsule())
                            }
                            
                            HStack(spacing: 20) {
                                StatusItem(title: "Active sLLM", value: "3 Units", icon: "brain.head.profile")
                                StatusItem(title: "Network", value: "Zero Trust", icon: "lock.shield")
                            }
                        }
                        .padding()
                        .background(AppTheme.glassGradient)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        // Feature Sections
                        Text("Core Solutions")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        VStack(spacing: 16) {
                            FeatureRow(title: "On-premise Infrastructure", subtitle: "Fully air-gapped sLLM deployment.", icon: "server.rack")
                            FeatureRow(title: "Privacy guard", subtitle: "End-to-end data encryption.", icon: "hand.raised.shield")
                            FeatureRow(title: "Compliance AI", subtitle: "Auto-reporting for security audits.", icon: "doc.text.magnifyingglass")
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.top)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct StatusItem: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(AppTheme.primary)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                Text(value)
                    .font(.body.bold())
                    .foregroundColor(.white)
            }
        }
    }
}

struct FeatureRow: View {
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(AppTheme.primary)
                .frame(width: 44, height: 44)
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.white.opacity(0.3))
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(16)
    }
}

#Preview {
    DashboardView()
}
