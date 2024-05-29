# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hanikamu::Services::Async do
  context 'when passing the wrong argument type' do
    let(:service) do
      class TestFooModule::Bar < Hanikamu::Service
        include Services::Async

        attribute :some_string, Dry::Types['string']

        def call!
          'hola'
        end
      end
      TestFooModule::Bar
    end

    describe '.call' do
      before do
        allow(service).to receive(:call)
      end

      subject { service::Async.call(some_string: 'hey') }
      it 'calls the the service .call method' do
        expect(service).to have_received(:call).with_arguments(some_string: 'hey')
      end
    end

    describe '.call!' do
      before do
        allow(service).to receive(:call!)
      end

      subject { service::Async.call!(some_string: 'hey') }
      it 'returns a Hanikamu::ActiveCommand::Error' do
        expect(service).to have_received(:call!).with_arguments(some_string: 'hey')
      end
    end
  end
end
