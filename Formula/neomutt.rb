class Neomutt < Formula
  desc "E-mail reader with support for Notmuch, NNTP and much more"
  homepage "https://neomutt.org/"
  url "https://github.com/neomutt/neomutt/archive/20210205.tar.gz"
  sha256 "77e177780fc2d8abb475d9cac4342c7e61d53c243f6ce2f9bc86d819fc962cdb"
  license "GPL-2.0-or-later"
  head "https://github.com/neomutt/neomutt.git"

  bottle do
    sha256 arm64_big_sur: "a3119427eec30804ee282513555975d22aaa2d959654a59dc0e7e9111014a626"
    sha256 big_sur:       "02c44bd0160b8c4118ee6c8c96569b8907b6bf9caa2b4f5de6091eb2a820a896"
    sha256 catalina:      "291d157a3ca06df36d33f772c5c7e34cf9e30b468d9d7abb9bb232aaad53d415"
    sha256 mojave:        "7e7f2b4645d82958e8ff7f068b50312622a7db16c10e142a25162ad519e1f61b"
  end

  depends_on "docbook-xsl" => :build
  depends_on "gettext"
  depends_on "gpgme"
  depends_on "libidn"
  depends_on "lmdb"
  depends_on "lua"
  depends_on "notmuch"
  depends_on "openssl@1.1"
  depends_on "tokyo-cabinet"

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    system "./configure", "--prefix=#{prefix}",
                          "--enable-gpgme",
                          "--with-gpgme=#{Formula["gpgme"].opt_prefix}",
                          "--gss",
                          "--lmdb",
                          "--notmuch",
                          "--sasl",
                          "--tokyocabinet",
                          "--with-ssl=#{Formula["openssl@1.1"].opt_prefix}",
                          "--with-ui=ncurses",
                          "--lua",
                          "--with-lua=#{Formula["lua"].prefix}"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/neomutt -F /dev/null -Q debug_level")
    assert_equal "set debug_level = 0", output.chomp
  end
end
