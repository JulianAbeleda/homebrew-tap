class DeepseekArkey < Formula
  desc "Standalone Arkey-style terminal CLI for DeepSeek"
  homepage "https://github.com/JulianAbeleda/deepseek-arkey"
  url "https://github.com/JulianAbeleda/deepseek-arkey/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "629b1030d861a5a469a6af1bf4e0f4dcf54d38dde173fae6028a1e3f8193a519"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "Usage: deepseek-arkey", shell_output("#{bin}/deepseek-arkey --help")
    assert_match "Usage: deepseek", shell_output("#{bin}/deepseek --help")
  end
end
