require './closed_section'

describe "ClosedSection" do
  let(:closed_section) { ClosedSection.new(lower: lower, upper: upper) }
  let(:other_closed_section) { ClosedSection.new(lower: lower, upper: upper) }

  context '整数閉区間を作成する場合' do
    context '閉区間を作ることができる（下端点より上端点が大きい）場合' do
      context '下端点 3、上端点 8 の場合' do
        # 具体値の説明の後に、実際の値を書く
        let(:lower) { 3 }
        let(:upper) { 8 }

        it "整数閉区間を生成できる" do
          expect(closed_section.is_a?(ClosedSection)).to eq(true)
        end

        # 下端点と上端点は 両方持っていることに意味と考えた場合、1 つのテストにまとめてもいいかもしれない。
        it "下端点 3 を持つ" do
          expect(closed_section.lower).to eq 3
        end

        it "上端点 8 を持つ" do
          expect(closed_section.upper).to eq 8
        end
      end
    end

    context '閉区間を作ることはできない（上端点より下端点が大きい）' do
      context '下端点 8、上端点 3 の場合' do
        let(:lower) { 8 }
        let(:upper) { 3 }

        it "整数閉区間を生成できない" do
          # エラーメッセージに引数の値が入ってることを確認できると良い。
          expect{ ClosedSection.new(lower: 8, upper: 3) }.to raise_error(RuntimeError)
        end
      end
    end
  end

  context "整数閉区間の機能" do
    context '文字列で返す' do
      context '下端点 3、上端点 8 の場合' do
        let(:lower) { 3 }
        let(:upper) { 8 }

        it "[3,8]を返すこと" do
          expect(closed_section.to_s).to eq('[3,8]')
        end
      end
    end

    context '指定する値が閉区間に含まれているか判定する' do
      let(:lower) { 3 }
      let(:upper) { 8 }

      context "下端点の場合" do  
        it "2が閉区間に含まれていないこと" do
          expect(closed_section.between?(number: 2)).to eq(false)
        end
  
        it "3が閉区間に含まれていること" do
          expect(closed_section.between?(number: 3)).to eq(true)
        end
      end
  
      context "上端点の場合" do
        it "8が閉区間に含まれていること" do
          expect(closed_section.between?(number: 8)).to eq(true)
        end
  
        it "9が閉区間に含まれていないこと" do
          expect(closed_section.between?(number: 9)).to eq(false)
        end
      end
    end

    context '別の整数閉区間と等価がどうか判定する' do
      let(:lower) { 3 }
      let(:upper) { 8 }

      it '別の整数閉区間の下端点と上端点が同じなら等価であること' do
        expect(closed_section.equal?(closed_section: other_closed_section)).to eq true
      end

      it '別の整数閉区間の下端点が異なり、上端点が同じなら不等価であること' do
        expect(closed_section.equal?(closed_section: ClosedSection.new(lower: lower + 1, upper: upper))).to eq false
      end

      it '別の整数閉区間の下端点が同じで、上端点が異なるなら不等価であること' do
        expect(closed_section.equal?(closed_section: ClosedSection.new(lower: lower, upper: upper + 1))).to eq false
      end
    end

    context '別の閉区間が自分の閉区間に含まれているかどうか判定する' do
      let(:lower) { 3 }
      let(:upper) { 8 }

      it '自分の閉区間の範囲内であれば、含まれていること' do
        expect(closed_section.include?(closed_section: ClosedSection.new(lower: lower + 1, upper: upper - 1))).to eq true
      end

      it '自分の閉区間と同じなら、含まれていること' do
        expect(closed_section.include?(closed_section: ClosedSection.new(lower: lower, upper: upper))).to eq true
      end

      it '自分の閉区間の下端点が範囲外なら、含まれていないこと' do
        expect(closed_section.include?(closed_section: ClosedSection.new(lower: lower - 1, upper: upper))).to eq false
      end

      it '自分の閉区間の上端点が範囲外なら、含まれていないこと' do
        expect(closed_section.include?(closed_section: ClosedSection.new(lower: lower, upper: upper + 1))).to eq false
      end
    end
  end
end
