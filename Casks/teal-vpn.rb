cask "teal-vpn" do
  version "1.0,76"
  sha256 "2702b2e468255a516105bfa04146c03f4f9a082953b5afccee7e3bbea5d00222"

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
