#!/usr/bin/env bash
set -euo pipefail

# Global keyboard/text behavior.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false
defaults write NSGlobalDomain AppleEnableMouseSwipeNavigateWithScrolls -bool true
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.875
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false

# Dock.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 64
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-tr-modifier -int 0

# Finder.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads/"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRecentTags -bool false

# Screenshots.
defaults write com.apple.screencapture location -string "$HOME/Downloads"
defaults write com.apple.screencapture location-last -string "$HOME/Downloads"
defaults write com.apple.screencapture style -string "display"
defaults write com.apple.screencapture target -string "file"
defaults write com.apple.screencapture video -bool true

# Trackpad.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

killall Dock >/dev/null 2>&1 || true
killall Finder >/dev/null 2>&1 || true
killall SystemUIServer >/dev/null 2>&1 || true
