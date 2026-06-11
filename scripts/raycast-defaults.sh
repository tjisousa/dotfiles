#!/usr/bin/env bash
set -euo pipefail

defaults write com.raycast.macos raycastGlobalHotkey -string "Command-49"
defaults write com.raycast.macos raycastPreferredWindowMode -string "compact"
defaults write com.raycast.macos raycastShouldFollowSystemAppearance -bool true
defaults write com.raycast.macos useHyperKeyIcon -bool true
defaults write com.raycast.macos "NSStatusItem Visible raycastIcon" -bool false
defaults write com.raycast.macos subscriptions_active -bool false
defaults write com.raycast.macos raycast_hyperKey_state -dict enabled -bool true includeShiftKey -bool true keyCode -int 57

echo "Raycast defaults applied. Restart Raycast for all changes to take effect."

