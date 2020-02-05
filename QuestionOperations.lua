function PopulateQuestionAndAnswers()

  local allTextItems = currentGameplayQuestions[#currentGameplayQuestions]:split(",")

  questionText = allTextItems[1]
  answerTextA = allTextItems[2]
  answerTextB = allTextItems[3]
  answerTextC = allTextItems[4]
  answerCorrectText = allTextItems[5]

  if answerTextA == answerCorrectText then
    answerCorrectOption = "A"
  elseif answerTextB == answerCorrectText then
    answerCorrectOption = "B"
  elseif answerTextC == answerCorrectText then
    answerCorrectOption = "C"
  end

end

function RandomiseQuestionOrder(questions)

  local randomisedQuestions = {}

  while #questions > 0 do
    local randomIndex = love.math.random(1, #questions)
    local randomQuestion = table.remove(questions, randomIndex)
    table.insert(randomisedQuestions, randomQuestion)
  end

  return randomisedQuestions

end

function GetFirstNQuestions(questions, n)

  local firstNQuestions = {}
  local counter = 1

  while counter <= n do
    if #questions > 0 then
      local question = table.remove(questions, 1)
      table.insert(firstNQuestions, question)
    end
    counter = counter + 1
  end

  return firstNQuestions
end
