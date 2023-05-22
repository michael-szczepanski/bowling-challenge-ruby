class ScoreCounter
  def count(scores)
    score = 0

    scores.each_with_index do |current, frame|
      if frame == 9
        score += final_frame_score(current)
        return score
      end

      if current[0] == 10
        extra_points = self.strike_extra_points(scores, frame)
        score += extra_points
      elsif current[0] + current[1] == 10
        extra_points = self.spare_extra_points(scores, frame)
        score += extra_points
      end

      score += current[0]
      score += current[1]
    end

    return score
  end

  def strike_extra_points(scores, frame)
    first_extra_roll = 0
    second_extra_roll = 0
    return 0 if scores[frame + 1].nil?

    first_extra_roll = scores[frame + 1][0]

    if first_extra_roll == 10
      second_extra_roll = scores[frame + 1][1] == 10 ? 10 : scores[frame + 2][0]
    else
      second_extra_roll = scores[frame + 1][1]
    end

    return first_extra_roll + second_extra_roll
  end

  def final_frame_score(scores)
    return scores[0] + scores[1] + scores[2]
  end

  def spare_extra_points(scores, frame)
    extra_roll = 0
    while extra_roll == 0
      frame += 1
      return extra_roll if scores[frame] == nil

      if scores[frame][0] != 0
        return scores[frame][0]
      elsif scores[frame][1] != 0
        return scores[frame][1]
      end
    end
  end
end