class JoeboyLv2Plugins < Formula
  desc "assortment of LV2 plugins"
  homepage "https://github.com/Joeboy/joeboy-lv2-plugins"
  head "https://github.com/Joeboy/joeboy-lv2-plugins.git"

  depends_on "pkg-config" => :build
  depends_on "gtk+"
  depends_on "lv2"
  depends_on "fluid-synth"
  depends_on "aubio"

  def install
    inreplace "fluidsynth/Makefile", "lv2-plugin", "lv2"

    ["fluidsynth", "pitchdetect", "shimmer", "amp_with_gui"].each do |plugin| # "visual_compressor" needs lv2-c++-tools
      cd "#{buildpath}/#{plugin}" do
        system "make", "install", "INSTALL_DIR=#{lib}/lv2"
      end
    end
  end

  test do
    assert_match /_lv2_descriptor/, shell_output("nm  #{lib}/lv2/fluidsynth.lv2/fluidsynth.so")
  end
end
