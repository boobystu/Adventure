function FileExists(fileName)

  local file = io.open(highScoreFile, "r")
  if (file) then
    file:close()
    return true
  end
  return false
end
