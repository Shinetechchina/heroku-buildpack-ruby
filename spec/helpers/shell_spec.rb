require 'spec_helper'


class FakeShell
  include LanguagePack::ShellHelpers
end


describe "ShellHelpers" do
  it "format ugly keys correctly" do
    env      = {%Q{ un"matched } => "bad key"}
    result   = FakeShell.new.command_options_to_string("bundle install", env:  env)
    expected = %Q{ env \\ un\\\"matched\\ =bad\\ key bash -c bundle\\ install 2>&1 }
    expect(result.strip).to eq(expected.strip)
  end

  it "formats ugly values correctly" do
    env      = {"BAD VALUE"      => %Q{ )(*&^%$#'$'\n''@!~\'\ }}
    result   = FakeShell.new.command_options_to_string("bundle install", env:  env)
    expected = %Q{ env BAD\\ VALUE=\\ \\)\\(\\*\\&\\^\\%\\$\\#\\'\\$\\''\n'\\'\\'@\\!\\~\\'\\  bash -c bundle\\ install 2>&1 }
    expect(result.strip).to eq(expected.strip)
  end
end
