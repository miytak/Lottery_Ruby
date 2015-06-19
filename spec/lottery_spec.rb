require_relative '../lib/lottery.rb'
describe Lottery do
  let(:lottery) { Lottery.new(size) }
  let(:size) { 1 }
  let(:names) { %w(John Jane Matz) }
  let(:add_member) { names.each{|name| lottery.add(name,1) } }
  describe '#initialize' do
    shared_examples '商品数確認' do
      it '引数に指定した数値と商品数が一致する' do
        expect(lottery.prize_count).to eq size
      end
    end
    context '引数が0の場合' do
      let(:size) { 0 }
      it_behaves_like '商品数確認'
    end
    context '引数が1の場合' do
      let(:size) { 1 }
      it_behaves_like '商品数確認'
    end
  end
  describe '#add' do
    it '同じ名前がすでに登録されている場合は追加しない' do
      lottery.add('John',1)
      lottery.add('John',1)
      expect(lottery.names.count('John')).to eq 1
    end

    it '別の名前を3人登録したらメンバーが3人になっている' do
      add_member
      expect(lottery.names.length).to eq 3
    end
  end
  describe '#names' do
    it '登録した3人の名前が返される' do
      add_member
      expect(lottery.names).to eq names
    end
  end
  describe '#winners' do
    shared_examples '該当者なし' do
      it '空の配列が返される' do
        expect(lottery.winners).to eq []
      end
    end
    context '商品数が0の場合' do
      let(:size) { 0 }
      it_behaves_like '該当者なし'
    end
    context '登録者が0人の場合' do
      it_behaves_like '該当者なし'
    end

    context '登録者数が商品数以下の場合' do
      let(:size) { 3 }
      it '登録した3人の名前が返される' do
        add_member
        expect(lottery.winners).to eq names
      end
    end

    context '登録者数が商品数より多い場合' do
      let(:size) { 2 }
      it '商品数分の名前が返される' do
        add_member
        expect(lottery.winners.length).to eq size
      end
    end

    context '重み付けされている場合' do
      let(:size) { 1 }
      it '100回試して重み付け順に当選する' do
        counts = {A1: 0, A3: 0, A5: 0, A10: 0}
        lottery.add("A1",1)
        lottery.add("A3",3)
        lottery.add("A5",5)
        lottery.add("A10",10)
        100.times do
          counts[lottery.winners.first.intern] += 1
        end
        expect(counts[:A1] < counts[:A3] && counts[:A3] < counts[:A5] && counts[:A5] < counts[:A10]).to eq true
      end
    end

  end
end
