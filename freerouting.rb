class Freerouting < Formula
  desc "Printed Circuit Board Routing Software"
  homepage "https://freerouting.mihosoft.eu/"
  url "https://bintray.com/miho/Freerouting/download_file?file_path=eu%2Fmihosoft%2Ffreerouting%2Ffreerouting%2F1.4.4%2Ffreerouting-1.4.4-executable.jar"
  sha256 "5d28868a4210ab27010542b7dafe136b98768b037db1c686d9479e189528f5b6"

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
      (libexec/"bin").install "freerouting-1.4.4-executable.jar" =>
                              "freerouting-executable.jar"
    end
    (bin/"FreeRouting").write <<~EOS
    #!/bin/bash
    exec java -jar "#{libexec}/bin/freerouting-executable.jar"
    EOS
    chmod 0555, bin/"FreeRouting"
  end
end
