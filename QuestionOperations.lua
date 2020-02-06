function PopulateQuestionAndAnswers()

  if #currentGameplayQuestions == 0 then
    return
  end

  local allTextItems = currentGameplayQuestions[#currentGameplayQuestions]:split(",")

  question.questionText = allTextItems[1]
  question.answerTextA = allTextItems[2]
  question.answerTextB = allTextItems[3]
  question.answerTextC = allTextItems[4]
  question.answerCorrectText = allTextItems[5]

  if question.answerTextA == question.answerCorrectText then
    question.answerCorrectOption = "A"
  elseif question.answerTextB == question.answerCorrectText then
    question.answerCorrectOption = "B"
  elseif question.answerTextC == question.answerCorrectText then
    question.answerCorrectOption = "C"
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

function RemoveLastQuestion()
  if #currentGameplayQuestions > 0 then
    table.remove(currentGameplayQuestions, #currentGameplayQuestions)
  end
end
