def atoi(str, default)
  begin
    return Integer(str)
  rescue
    return default
  end
end
