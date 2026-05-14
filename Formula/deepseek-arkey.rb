class DeepseekArkey < Formula
  desc "Standalone Arkey-style terminal CLI for DeepSeek"
  homepage "https://github.com/JulianAbeleda/deepseek-arkey"
  url "https://github.com/JulianAbeleda/deepseek-arkey/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dbf67287a463be7494d16f7ed4ee9b2768c8c6bfd62c0a38c7d0fe8a5b54291c"
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
