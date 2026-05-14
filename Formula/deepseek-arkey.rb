class DeepseekArkey < Formula
  desc "Standalone Arkey-style terminal CLI for DeepSeek"
  homepage "https://github.com/JulianAbeleda/deepseek-arkey"
  url "https://github.com/JulianAbeleda/deepseek-arkey/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c5b0a0027fda8b6035cad11c9a67176c29b08fd587ecef915bcc57145fd52e1d"
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
