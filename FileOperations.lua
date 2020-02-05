function FileExists(fileName)

  local file = io.open(highScoreFile, "r")
  if (file) then
    file:close()
    return true
  end
  return false
end

function ReadQuestionFile()
  local file = io.open("questions.txt", "r")

  for line in file:lines() do
    if line ~= "" then
      table.insert(allQuestions, line)
    end
  end
  file:close()
end
