require 'spec_helper'

module WebsocketRails

  describe SpecHelperEvent do

    before do
      @dispatcher = double(:dispatcher)
      allow(Dispatcher).to receive(:new).and_return @dispatcher
      @event = SpecHelperEvent.new('my_event', 'my_data')
    end

    describe 'initialize' do

      it 'should initialize the name and namespace of the event' do
        expect(@event.namespace).to eq([:global])
        expect(@event.name).to eq(:my_event)
      end

      it 'should initialize the data of the event' do
        expect(@event.data).to eq('my_data')
      end

      it 'should set the event to not triggered' do
        expect(@event).to_not be_triggered
      end

    end

    describe 'trigger' do

      it 'should set the triggered variable to true' do
        @event.trigger
        expect(@event).to be_triggered
      end

    end

    describe 'dispatch' do

      it 'should invoke dispatch on the dispatcher object' do
        expect(@dispatcher).to receive(:dispatch).with(@event)
        @event.dispatch
      end

      it 'should return itself to be able to chain matchers' do
        allow(@dispatcher).to receive(:dispatch)
        expect(@event.dispatch).to eq(@event)
      end

    end

  end

end

describe 'create_event' do

  it 'should create a SpecHelperEvent with the correct parameters' do
    event = create_event('my_event','my_data')
    expect(event).to be_a WebsocketRails::SpecHelperEvent
    expect(event.name).to eq(:my_event)
    expect(event.data).to eq('my_data')
  end

end
