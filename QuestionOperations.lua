function PopulateQuestionAndAnswers()

  local allTextItems = questions[#questions]:split(",")

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

  randomisedQuestions = {}

  while #questions > 0 do
    randomIndex = love.math.random(1, #questions)
    randomQuestion = table.remove(questions, randomIndex)
    table.insert(randomisedQuestions, randomQuestion)
  end

  return randomisedQuestions

end
