# frozen_string_literal: true

def atoi(str, default)
  Integer(str)
rescue StandardError
  default
end
