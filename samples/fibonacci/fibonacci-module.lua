--from: https://gist.github.com/SegFaultAX/2772595
function fibonacci(n)
  local a, b = 0, 1

  for i = 1, n do
    a, b = b, a + b
  end
  return a
end

return fibonacci
