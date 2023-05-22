require 'score_counter'

RSpec.describe ScoreCounter do
  it 'passes excersise example' do
    score_counter = ScoreCounter.new
    scores = []
    scores << [1,4]
    scores << [4,5]
    scores << [6,4]
    scores << [5,5]
    scores << [10,0]
    scores << [0,1]
    scores << [7,3]
    scores << [6,4]
    scores << [10,0]
    scores << [2,8,6]
    expect(score_counter.count(scores)).to eq 133
  end

  context 'count method' do
    it 'counts scores correctly for a gutter game' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [0,0])
      scores << [0,0,0]
      expect(score_counter.count(scores)).to eq 0
    end

    it 'counts scores correctly for a partial game' do
      score_counter = ScoreCounter.new
      scores = Array.new(5, [4,5])
      scores << [10, 0]
      scores << [4,5]
      expect(score_counter.count(scores)).to eq 73
    end

    it 'counts scores correctly for a game with no strikes/spares and gutter in second roll' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [9,0])
      scores << [9,0,0]
      expect(score_counter.count(scores)).to eq 90
    end

    it 'counts scores correctly for a game with no strikes/spares in mixed rolls' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [2,3])
      scores << [2,3,0]
      expect(score_counter.count(scores)).to eq 50
    end

    it 'counts scores correctly for a perfect game' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [10,0])
      scores << [10,10,10]
      expect(score_counter.count(scores)).to eq 300
    end

    it 'counts scores correctly for a game of full spares' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [0, 10])
      scores << [0, 10, 0]
      expect(score_counter.count(scores)).to eq 190
    end
  end

  context 'strike_extra_points method' do
    it 'finds the correct points if the next two rolls are non-zero' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [2,3])
      scores << [2,3,0]
      expect(score_counter.strike_extra_points(scores, 2)).to eq 5
    end

    it 'finds the correct points for the next two non-zero rolls' do
      score_counter = ScoreCounter.new
      scores = Array.new(9, [10,0])
      scores << [10,10,10]
      expect(score_counter.strike_extra_points(scores, 2)).to eq 20
    end
  end

  context 'final_frame_score method' do
    it 'returns correct points for the final round' do
      score_counter = ScoreCounter.new
      scores1 = [10,10,10]
      scores2 = [2, 3, 0]
      expect(score_counter.final_frame_score(scores1)).to eq 30
      expect(score_counter.final_frame_score(scores2)).to eq 5
    end
  end

  context 'spare_extra_points method' do
    it 'returns correct points for next non-zero ball' do
      score_counter = ScoreCounter.new
      scores = [[0,10],[2,3]]
      expect(score_counter.spare_extra_points(scores, 0)).to eq 2
    end
  end    
end