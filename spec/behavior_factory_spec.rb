require 'helper'

describe BehaviorFactory do
  let(:some_behavior) { stub('some behavior', required_behaviors: []) }
  let(:object_context) { mock('object context') }
  let(:some_actor) { stub('some actor', this_object_context: object_context) }

  before do
    object_context.stubs(:[]).with(:do_not_exist).returns(nil)
    object_context.stubs(:[]).with(:shootable).returns(some_behavior)
    some_behavior.stubs(:configure)
  end

  describe "#add_behavior" do
    it 'creates the behavior based on the actor and symbol behavior_def' do
      some_behavior.expects(:configure).with({})

      subject.add_behavior some_actor, :shootable
    end

    it 'configures the behavior with the given opts' do
      opts = {some: 'opts'}
      some_behavior.expects(:configure).with(opts)

      subject.add_behavior some_actor, :shootable, opts 
    end

    it 'raises on nil actor' do
      lambda { subject.add_behavior nil, {} }.should raise_exception(/nil actor/)
    end

    it 'raises on nil behavior def' do
      lambda { subject.add_behavior some_actor, nil }.should raise_exception(/nil behavior definition/)
    end

    it 'raises for missing behavior' do
      lambda { subject.add_behavior actor, :do_not_exist }.should raise_exception
    end

    it 'creates all required behaviors'
  end
end
