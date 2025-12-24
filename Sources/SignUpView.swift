import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AuthViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 12) {
                    Text("Create Account")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Join the Zero Trust sLLM Network")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 40)
                
                // Form
                VStack(spacing: 15) {
                    CustomTextField(icon: "person", placeholder: "Full Name", text: $name)
                    CustomTextField(icon: "envelope", placeholder: "Email", text: $email)
                    CustomTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                    CustomTextField(icon: "lock.shield", placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        Task {
                            if password == confirmPassword {
                                let success = await viewModel.register(name: name, email: email, password: password)
                                if success {
                                    dismiss()
                                }
                            } else {
                                viewModel.errorMessage = "Passwords do not match"
                            }
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign Up")
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(AppTheme.primary)
                    .cornerRadius(16)
                    .shadow(color: AppTheme.primary.opacity(0.3), radius: 10, x: 0, y: 5)
                    .disabled(viewModel.isLoading)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Text("Already have an account? Sign In")
                        .font(.footnote)
                        .foregroundColor(AppTheme.primary)
                }
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
