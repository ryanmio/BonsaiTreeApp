# BonsaiTreeApp

## Deep Linking Functionality

The BonsaiTreeApp implements deep linking to allow users to open specific bonsai profiles directly through custom URLs. This feature enhances the app's usability by enabling quick access to profiles and easy sharing.

### How It Works

1. **URL Scheme**: 
   - The app uses the custom URL scheme `bonsaiapp://`.
   - Example URL: `bonsaiapp://<profile-uuid>`

2. **Handling Deep Links**:
   - The `BonsaiTreeAppApp` struct contains an `onOpenURL` modifier that calls `handleDeepLink(url:)` when a deep link is received.
   - `handleDeepLink(url:)` parses the URL, extracts the profile UUID, and posts a notification to open the corresponding profile.

3. **Navigation**:
   - `ContentView` listens for the `.openProfile` notification.
   - When received, it updates `selectedProfile` and triggers navigation to `ProfileDetailView`.

4. **Generating Deep Links**:
   - In `ProfileDetailView`, a deep link URL is generated for each profile.
   - Users can copy this URL to share or use with NFC tags.

5. **Opening Deep Links**:
   - When a user taps a deep link URL, iOS opens the app and passes the URL to `handleDeepLink(url:)`.
   - The app then navigates to the specified profile.

### Usage

- To share a profile, open the profile in the app and copy the deep link URL.
- To use with NFC tags, write the deep link URL to an NFC tag using an NFC writer app.
- When the URL is opened (e.g., from a message or NFC tag), the app will launch and navigate directly to the profile.

### Implementation Details

- `BonsaiTreeAppApp.swift`: Contains the `handleDeepLink(url:)` function.
- `ContentView.swift`: Listens for deep link notifications and handles navigation.
- `ProfileDetailView.swift`: Displays and allows copying of the deep link URL.
- `BonsaiProfilesViewModel.swift`: Manages profile data and provides methods to find profiles by UUID.

### Note

Ensure that the app's Info.plist contains the necessary URL scheme configuration for `bonsaiapp`.