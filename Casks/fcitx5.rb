cask "fcitx5" do
  version "0.1.0"
  sha256 "4a05a1ddf31c72a21b7118367d61398068f383966acd0ac70a7483bc719f64db"
  depends_on macos: ">= :ventura"

  url "https://github.com/fcitx-contrib/fcitx5-macos-installer/releases/download/#{version}/Fcitx5Installer.zip"
  name "Fcitx5 macOS"
  desc "Fcitx5 input method framework for macOS"
  homepage "https://fcitx-contrib/fcitx5-macos"

  preflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/Fcitx5Installer.app"]
  end

  installer script: {
    executable: "#{staged_path}/Fcitx5Installer.app/Contents/Resources/install.sh",
    args: [ENV["SUDO_USER"] || Etc.getlogin, "#{staged_path}/Fcitx5Installer.app/Contents/Resources"],
    sudo: true,
  }

  uninstall script: {
    executable: "/Library/Input Methods/Fcitx5.app/Contents/Resources/uninstall.sh",
    args: [ENV["SUDO_USER"] || Etc.getlogin, "false"],
    sudo: true,
  }
end
