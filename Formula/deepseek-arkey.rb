class DeepseekArkey < Formula
  desc "Standalone Arkey-style terminal CLI for DeepSeek"
  homepage "https://github.com/JulianAbeleda/deepseek-arkey"
  url "https://github.com/JulianAbeleda/deepseek-arkey/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "5d67be1cfc2d6752b59590475100b37ede691f1c2621698d4fc4cc035b605c7f"
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
