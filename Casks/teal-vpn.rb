cask "teal-vpn" do
  version "1.0,39"
  sha256 "a042691cd2c7f8be7eadcc43ae20f76e8172e407b6f16a291f33569b41a96f61"

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
