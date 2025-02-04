# 💬 Chat-R

Chat-R is a feature-rich Flutter-based chat application that enables real-time communication across multiple platforms. Whether for personal or professional use, Chat-R provides an intuitive interface with seamless messaging capabilities.

## 🚀 Features

- **Real-time Messaging**: Instant chat with smooth and secure message delivery.
- **User Authentication**: Secure login and registration with account management.
- **Group Chats**: Create and manage group conversations effortlessly.
- **Media Sharing**: Send images, videos, and documents securely.
- **Profile Customization**: Update user information, set profile pictures, and manage settings.
- **Cross-Platform Support**: Works on iOS, Android, Web, Windows, macOS, and Linux.
- **Dark Mode**: Toggle between light and dark themes for an enhanced user experience.

## 📸 Screenshots

<p align="center">
  <img src="assets/screenshots/chat-home.png" width="30%" alt="Home Screen">
  <img src="assets/screenshots/chat-screen.png" width="30%" alt="Chat Screen">
  <img src="assets/screenshots/group-chat.png" width="30%" alt="Group Chat Screen">
</p>
<p align="center">
  <img src="assets/screenshots/profile-screen.png" width="30%" alt="Profile Screen">
  <img src="assets/screenshots/settings-screen.png" width="30%" alt="Settings Screen">
  <img src="assets/screenshots/login-screen.png" width="30%" alt="Login Screen">
</p>

## 🛠 Installation

To run this project on your local machine, follow these steps:

1. **Clone the repository:**

    ```sh
    git clone https://github.com/saurabhisane/Chat-R.git
    cd Chat-R
    ```

2. **Install Flutter and Dart:**

    Follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install) to set up Flutter on your machine.

3. **Install dependencies:**

    ```sh
    flutter pub get
    ```

4. **Run the app:**

    ```sh
    flutter run
    ```

## 📂 Project Structure

```plaintext
Chat-R/
├── lib/
│   ├── screens/
│   │   ├── chat_home_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── group_chat_screen.dart
│   │   ├── login_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── signup_screen.dart
│   │   └── splash_screen.dart
│   ├── widgets/
│   │   ├── message_bubble.dart
│   │   ├── user_avatar.dart
│   │   ├── input_field.dart
│   │   └── ...
│   ├── models/
│   │   ├── user.dart
│   │   ├── message.dart
│   │   └── ...
│   ├── constants.dart
│   ├── main.dart
│   └── ...
├── assets/
│   ├── images/
│   │   ├── user_avatar.png
│   │   ├── chat_icon.png
│   │   ├── dark_mode_icon.png
│   │   └── ...
├── test/
│   └── ...
├── pubspec.yaml
└── README.md
```

## Screens

### lib/screens/

- `chat_home_screen.dart`: Displays a list of conversations and recent chats.
- `chat_screen.dart`: Handles one-on-one messaging.
- `group_chat_screen.dart`: Enables group conversations with multiple participants.
- `login_screen.dart`: Manages user authentication and login.
- `profile_screen.dart`: Allows users to update their profile and preferences.
- `settings_screen.dart`: Provides customization options and settings.
- `signup_screen.dart`: Facilitates new user registration.
- `splash_screen.dart`: Initial loading screen when the app launches.

## 🤝 Contributing

We welcome contributions from the community! To contribute:

1. **Fork the repository.**
2. **Create a new branch:**

    ```sh
    git checkout -b feature/YourFeatureName
    ```

3. **Make your changes and commit them:**

    ```sh
    git commit -m 'Add some feature'
    ```

4. **Push to the branch:**

    ```sh
    git push origin feature/YourFeatureName
    ```

5. **Open a pull request.**

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

Developed by [Saurabh Isane](https://github.com/saurabhisane). For queries or support, please contact [saurabhisane@example.com](mailto:saurabhisane@example.com).
