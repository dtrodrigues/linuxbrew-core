class Mdcat < Formula
  desc "Show markdown documents on text terminals"
  homepage "https://github.com/lunaryorn/mdcat"
  url "https://github.com/lunaryorn/mdcat/archive/mdcat-0.18.2.tar.gz"
  sha256 "1098fac512072db21e9b466e66843350649abebf867bc22feeebda10d86e6787"

  bottle do
    cellar :any_skip_relocation
    sha256 "6c7ffbfe79e0dff7e050399c9c18d799de9f7e92571062ef889e2a38a2548c1c" => :catalina
    sha256 "0a7218b021e223e4e502c6e5b4563e6666f9e57d7a6e676795719cc4704ad12d" => :mojave
    sha256 "b911b901adb34338104b363d06ea0286dfe8a1e132e053351bfdf5c2c7fc991c" => :high_sierra
    sha256 "d6cfe5e428f8b113536214ddb1b8ed5fbd0f419dc2304f0c92b631b77263489d" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "rust" => :build
  unless OS.mac?
    depends_on "llvm" => :build
    depends_on "pkg-config" => :build
    depends_on "openssl@1.1"
  end

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    (testpath/"test.md").write <<~EOS
      _lorem_ **ipsum** dolor **sit** _amet_
    EOS
    output = shell_output("#{bin}/mdcat --no-colour test.md")
    assert_match "lorem ipsum dolor sit amet", output
  end
end
