require "analysers_test_helper"
require "rubycritic/analysers/churn"
require "rubycritic/source_control_systems/base"

describe Rubycritic::Analyser::Churn do
  before do
    @analysed_modules = [AnalysedModuleDouble.new(:path => "path_to_some_file.rb")]
    analyser = Rubycritic::Analyser::Churn.new(@analysed_modules)
    analyser.source_control_system = SourceControlSystemDouble.new
    analyser.run
  end

  it "calculates the churn of each file and adds it to analysed_modules" do
    @analysed_modules.each do |analysed_module|
      analysed_module.churn.must_equal 1
    end
  end

  it "calculates the date of the last commit of each file and adds it to analysed_modules" do
    @analysed_modules.each do |analysed_module|
      analysed_module.committed_at.must_equal "2013-10-09 12:52:49 +0100"
    end
  end
end

class SourceControlSystemDouble < Rubycritic::SourceControlSystem::Base
  def revisions_count(_path)
    1 # churn
  end

  def date_of_last_commit(_path)
    "2013-10-09 12:52:49 +0100"
  end
end
