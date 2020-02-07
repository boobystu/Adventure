function AddToScrolls()

  local scroll = {}
  scroll.questionText = question.questionText
  scroll.answerTextA = question.answerTextA
  scroll.answerTextB = question.answerTextB
  scroll.answerTextC = question.answerTextC
  scroll.answerCorrectText = question.answerCorrectText
  scroll.answerCorrectOption = question.answerCorrectOption
  scroll.url = question.url
  scroll.read = false

  local scrollLocationIndex = math.random(1, #endGameScrollLocations)
  local scrollLocation = table.remove(endGameScrollLocations, scrollLocationIndex)
  scroll.endScreenXCoord = scrollLocation.x
  scroll.endScreenYCoord = scrollLocation.y
  table.insert(scrolls, scroll)
end

function PopulateEndGameScrollLocations()

  -- TODO Parameterise this to take in number of questions per game and generate that many scrollLocations

  endGameScrollLocations = {}

  table.insert(endGameScrollLocations, {["x"] = 100, ["y"] = 100})
  table.insert(endGameScrollLocations, {["x"] = 200, ["y"] = 200})
  table.insert(endGameScrollLocations, {["x"] = 300, ["y"] = 300})
  table.insert(endGameScrollLocations, {["x"] = 400, ["y"] = 400})
  table.insert(endGameScrollLocations, {["x"] = 500, ["y"] = 480})

end

function AllScrollsRead()

  if #scrolls == 0 then
    return true
  end

  for i = 1, #scrolls, 1 do
      if scrolls[i].read == false then
        return false
      end
  end

  return true

end
