class Boltbeam < Formula
  desc "Audit LLM inference time against a measured roofline"
  homepage "https://github.com/JulianAbeleda/BoltBeam-Public"
  url "https://github.com/JulianAbeleda/BoltBeam-Public/archive/refs/tags/v0.3.8.tar.gz"
  sha256 "022e55f636d8725f9344639204207224ccc6f245f7578c25c3e3c4595d1f3a7f"
  license "MIT"

  depends_on "go" => :build
  depends_on "python@3.12"

  def install
    python = formula_opt_bin("python@3.12")/"python3.12"

    # The whole tree is the checkout `boltbeam tui` and the reports read from (tui/, schemas/, docs/).
    libexec.install Dir["*"]

    # Build the screen once, with BoltBeam's own build, so it writes the source hash and never rebuilds at run time.
    ENV["GOTOOLCHAIN"] = "local"
    system python, "-c", <<~PY
      import pathlib, shutil, sys
      sys.path.insert(0, "#{libexec}")
      from boltbeam.cli import tui
      tui.build(pathlib.Path("#{libexec}"), shutil.which("go"), pathlib.Path("#{libexec}/tui-bin/boltbeam-tui"))
    PY

    # Runs default to ~/boltbeam-runs: the checkout's own runs/ is inside the Cellar and an upgrade would delete it.
    (bin/"boltbeam").write <<~SH
      #!/bin/bash
      if [ -z "$BOLTBEAM_REPO" ]; then
        export BOLTBEAM_REPO="#{opt_libexec}"
        export BOLTBEAM_TUI_DIR="${BOLTBEAM_TUI_DIR:-#{opt_libexec}/tui-bin}"
      fi
      export BOLTBEAM_RUNS="${BOLTBEAM_RUNS:-$HOME/boltbeam-runs}"
      export PYTHONPATH="$BOLTBEAM_REPO${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{python}" -m boltbeam.cli "$@"
    SH
  end

  def caveats
    <<~EOS
      Runs are kept in ~/boltbeam-runs (set BOLTBEAM_RUNS to use another folder).
      Start with `boltbeam doctor`, then `boltbeam tui`.
    EOS
  end

  test do
    assert_match "selfcheck: PASS", shell_output("#{bin}/boltbeam selfcheck")
    assert_match "apple_m3_10c", shell_output("#{bin}/boltbeam tui --json chips")
  end
end
