cask "teal-vpn" do
  version "1.0,45"
  sha256 "6b4507f589a360809819801ba37f366aef36e4a6c6748e3f5cc68333507b51b9"

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
