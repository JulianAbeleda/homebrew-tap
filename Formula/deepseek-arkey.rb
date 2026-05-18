class DeepseekArkey < Formula
  desc "Standalone Arkey-style terminal CLI for DeepSeek"
  homepage "https://github.com/JulianAbeleda/deepseek-arkey"
  url "https://github.com/JulianAbeleda/deepseek-arkey/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "1d18acd1104f03f0bb40d6a97b4e7ba07730a4f7adaebbdcd66885d285c0d08f"
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
