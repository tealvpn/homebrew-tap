cask "teal-vpn" do
  version "1.0,42"
  sha256 "aca85fdd36cbff31cc99cc705b10bcbb731513d15fb47b93d9899987aa00ae72"

  url "https://download.tealvpn.com/mac/TealVPN-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Teal VPN"
  desc "Private VPN with a free plan (500 MB a day), made for networks that block VPNs"
  homepage "https://tealvpn.com/mac"

  livecheck do
    url "https://download.tealvpn.com/mac/latest.json"
    regex(/TealVPN[._-]v?(\d+(?:\.\d+)*)[._-](\d+)\.dmg/i)
    strategy :json do |json, regex|
      json.dig("files", "dmg", "file")&.scan(regex)&.map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  depends_on macos: :ventura

  app "Teal VPN.app"

  uninstall quit: "com.tealvpn.client.direct"

  zap trash: [
    "~/Library/Application Support/Teal VPN",
    "~/Library/Caches/com.tealvpn.client.direct",
    "~/Library/Preferences/com.tealvpn.client.direct.plist",
  ]
end
