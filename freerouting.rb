class Freerouting < Formula
  desc "Printed Circuit Board Routing Software"
  homepage "https://freerouting.mihosoft.eu/"
  url "https://bintray.com/miho/Freerouting/download_file?file_path=eu%2Fmihosoft%2Ffreerouting%2Ffreerouting%2F1.4.2%2Ffreerouting-1.4.2-executable.jar"
  sha256 "e0235326c638d7869c88b974f94091f721ced092aa1f5da6fe219810a0f29c1d"

  head do
    url "https://github.com/freerouting/freerouting.git"
  end

  devel do
    url "https://github.com/freerouting/freerouting.git", :tag => "v1.4.4"
    version "1.4.4"
  end

  depends_on :java => "1.11+"

  def install
    if build.head? || build.devel?
      system "./gradlew", "build"
      (libexec/"bin").install "build/libs/freerouting-executable.jar"
    else
      (libexec/"bin").install "freerouting-1.4.2-executable.jar" =>
                              "freerouting-executable.jar"
    end
    (bin/"FreeRouting").write <<~EOS
    #!/bin/bash
    exec java -jar "#{libexec}/bin/freerouting-executable.jar"
    EOS
    chmod 0555, bin/"FreeRouting"
  end
end
