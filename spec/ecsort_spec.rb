# frozen_string_literal: true

require "json"
require_relative "../lib/ecsort/cli"

RSpec.describe Ecsort do
  describe "#sort_ecs_task_definition" do
    let!(:unsorted_definition) { File.read("spec/files/input.json") }
    let!(:sorted_definition) { JSON.pretty_generate(JSON.parse(File.read("spec/files/expected.json"))) }

    it "sorts ECS task definitions correctly" do
      sorted_definition = JSON.pretty_generate(JSON.parse(File.read("spec/files/expected.json")))
      expect(Ecsort.sort_ecs_task_definition(unsorted_definition)).to eq(sorted_definition)
    end
  end
end
