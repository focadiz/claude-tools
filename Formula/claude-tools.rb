class ClaudeTools < Formula
  desc "Launch and orchestrate Claude Code sessions in iTerm and tmux"
  homepage "https://github.com/focadiz/claude-tools"
  url "https://github.com/focadiz/claude-tools.git", tag: "v0.1.0"
  version "0.1.0"
  head "https://github.com/focadiz/claude-tools.git", branch: "main"

  depends_on :macos
  depends_on "gh"
  depends_on "jq"
  depends_on "tmux"

  def install
    bin.install "claude-launcher", "claude-dispatch"
  end

  test do
    assert_match "usage", shell_output("#{bin}/claude-launcher --help")
  end
end
