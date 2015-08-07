require 'spec_helper'

describe GoTranslator do
  it 'has a version number' do
    expect(GoTranslator::VERSION).not_to be nil
  end

  context 'valid response from server' do
    it 'translates successfully' do
      expect(Net::HTTP).to receive(:get).and_return("[[[\"\xE4\xBD\xA0\xE5\xA5\xBD\xE4\xB8\x96\xE7\x95\x8C\",\"hello world\",,,0],[,,\"N\xC7\x90 h\xC7\x8Eo sh\xC3\xACji\xC3\xA8\"]],,\"en\"]")
      expect(GoTranslator.translate('random')).to eq "你好世界"
    end
  end

  context 'no response from server' do
    it 'returns empty string' do
      expect(Net::HTTP).to receive(:get).and_return('')
      expect(GoTranslator.translate('random')).to eq ''
    end
  end 

  context 'there is an exception from server' do
    it 'returns empty string' do
      expect(Net::HTTP).to receive(:get).and_raise
      expect(GoTranslator.translate('random')).to eq ''
    end
  end 
end