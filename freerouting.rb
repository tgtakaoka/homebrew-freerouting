class Freerouting < Formula
  desc "Printed Circuit Board Routing Software"
  homepage "https://freerouting.org"
  head "https://github.com/freerouting/freerouting.git"

  depends_on :java => "1.7+"

  def install
    (libexec/"bin").install "binaries/FreeRouting.jar"
    (bin/"FreeRouting").write <<~EOS
    #!/bin/bash
    exec java -jar "#{libexec}/bin/FreeRouting.jar"
    EOS
    chmod 0555, bin/"FreeRouting"
  end
end
