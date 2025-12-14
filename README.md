

# window-manager: Smart Window Manager for Windows (AutoHotkey)

This repository provides a simple yet powerful AutoHotkey v1.1 script that modifies the default window resizing and maximization behavior on Windows 10 and 11, improving efficiency and predictability.

The script ensures specific actions trigger automatic maximization or smooth, controlled resizing, while leaving standard dragging behavior unaffected.

## ✨ Features

This script implements the following customized window management rules:

| Action | Behavior | Details |
| :--- | :--- | :--- |
| **Window Resize (End)** | **Auto-Maximize** | If a non-maximized window reaches **90% or more** of the display's work area (height **and** width), it is automatically maximized. |
| **Restore Button Click** | **Smart Restore** | Clicking the restore button triggers a **smooth animation** to resize the window to **50% of the display, centered.** |
| **Window Drag (Title Bar)** | **Native Restore** | Dragging a maximized window by its title bar uses standard Windows behavior (restoring to its pre-maximized size). The script does not interfere. |

-----

## 💻 Prerequisites

This script requires **AutoHotkey v1.1** to run.

  * **Install AutoHotkey:** Download and install the application from the official site: [https://www.autohotkey.com/](https://www.autohotkey.com/)
  * **AutoHotkey Source Code:** [https://github.com/AutoHotkey/AutoHotkey](https://github.com/AutoHotkey/AutoHotkey)

## 🚀 Installation and Setup

The included `InstallStartup.cmd` script makes setup fast and automatic.

### Step 1: Download the Code

Choose one of the following methods to get the repository files:

  * **Git Clone:**
    ```bash
    git clone https://github.com/RMNO21/window-manager.git
    cd window-manager
    ```
  * **Download ZIP:**
    1.  Go to the main [GitHub page](https://github.com/RMNO21/window-manager).
    2.  Click the green **`< > Code`** button and select **Download ZIP**.
    3.  Extract the contents to a permanent location (e.g., `C:\Scripts\WindowManager`).

### Step 2: Run the Installer

Once you are inside the `window-manager` folder (or the extracted folder):

1.  **Double-click** the `InstallStartup.cmd` file.

The installer will perform the following actions:

  * It copies the `WindowManager.ahk` file directly to your Windows Startup folder.
  * This ensures the script runs automatically every time you log in.
  * The script runs silently in the background (no system tray icon).

-----

## ⚙️ Customization

You can easily change the resize behavior, maximize threshold, and animation speed by editing the `WindowManager.ahk` file.

Open `WindowManager.ahk` and modify the values under the **USER CUSTOMIZATION SECTION**:

```autohotkey
; --- 90% AUTO-MAXIMIZE RULE ---
MaxThreshold := 0.90         ; Change to 0.85 for 85% threshold.

; --- RESTORE BUTTON BEHAVIOR ---
RestoreSizePercent := 0.50   ; Change to 0.75 for 75% size restore.

; --- ANIMATION SMOOTHNESS ---
AnimationSteps := 10         ; Higher number = smoother animation
AnimationSpeed := 10         ; Lower number (in milliseconds) = faster animation
```

## 📄 License

This project is distributed under the **GNU General Public License**. Please refer to the `LICENSE` file in the repository for full details.
