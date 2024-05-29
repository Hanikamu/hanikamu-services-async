# frozen_string_literal: true

require 'spec_helper'
require 'hanikamu-service'

RSpec.describe Hanikamu::Services::Async, type: :job do
  context 'when passing the wrong argument type' do
    let(:service) do
      module TestFooModule
        class Bar < Hanikamu::Service
          include Hanikamu::Services::Async

          attribute :some_string, Dry::Types['string']

          def call!
            'hola'
          end
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
        subject
        expect(service).to have_received(:call).with(some_string: 'hey')
      end
    end

    describe '.call!' do
      before do
        allow(service).to receive(:call!)
      end

      subject { service::Async.call!(some_string: 'hey') }
      it 'returns a Hanikamu::ActiveCommand::Error' do
        subject
        expect(service).to have_received(:call!).with(some_string: 'hey')
      end
    end
  end
end
