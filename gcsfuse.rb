class Gcsfuse < Formula
  desc "User-space file system for interacting with Google Cloud"
  homepage "https://github.com/googlecloudplatform/gcsfuse"
  url "https://github.com/GoogleCloudPlatform/gcsfuse/archive/v0.41.10.tar.gz"
  sha256 "91228dae3b7fdcdbd2b86d02aa470a636d09f85e60bcc9e63db72001e25976e0"
  license "Apache-2.0"
  head "https://github.com/GoogleCloudPlatform/gcsfuse.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "926378839715e3628210c2996659c3741025ca5a4c451af5ed4f6b5abece32ed"
  end

  depends_on "go" => :build
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    # Build the build_gcsfuse tool. Ensure that it doesn't pick up any
    # libraries from the user's GOPATH; it should have no dependencies.
    ENV.delete("GOPATH")
    system "go", "build", "./tools/build_gcsfuse"

    # Use that tool to build gcsfuse itself.
    gcsfuse_version = build.head? ? Utils.git_short_head : version
    system "./build_gcsfuse", buildpath, prefix, gcsfuse_version
  end

  test do
    system "#{bin}/gcsfuse", "--help"
    system "#{sbin}/mount.gcsfuse", "--help"
  end
end
