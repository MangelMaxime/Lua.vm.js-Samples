local window = js.global
local document = window.document

local ui = {
  date = document:querySelector(".date"),
  time = document:querySelector(".time")
}

local days = {
  Sun = "Sun",
  Mon = "Mon",
  Tue = "Tue",
  Wed = "Wed",
  Thu = "Thu",
  Fri = "Fri",
  Sat = "Sat"
}

local daysIndex = {
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat"
}

local months = {
  Jan = "January",
  Feb = "February",
  Mar = "March",
  Apr = "April",
  May = "May",
  Jun = "June",
  Jul = "July",
  Aug = "August",
  Sep = "September",
  Oct = "October",
  Nov = "November",
  Dec = "December"
}

local monthsIndex = {
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
}

function startClock()
  if ui.date ~= nil and ui.time ~= nil then
    tickClock()
  end
end

function tickClock()
  local today = js.new(window.Date)
  local dayOfMonth, dayIndex, monthIndex, year, h, m, s =
    formatTimeNumber(today:getDate()),
    today:getDay(),
    today:getMonth(),
    today:getFullYear(),
    today:getHours(),
    formatTimeNumber(today:getMinutes()),
    formatTimeNumber(today:getSeconds())

  local day, month =
    days[extractDayAlias(dayIndex)],
    months[extractMonthDalias(monthIndex)]

  ui.date.innerHTML = string.format("%s. %s %s %s", day, dayOfMonth, month, year)
  ui.time.innerHTML = string.format("%s : %s : %s", h, m, s)

  window:requestAnimationFrame(tickClock)

end

function extractDayAlias(rank)
  return daysIndex[rank + 1] -- Add one to rank as table a one index base
end

function extractMonthDalias(rank)
  return monthsIndex[rank + 1] -- Add one to rank as table a one index base
end

function formatTimeNumber(num)
  if num < 10 then
    num = "0" .. num
  end
  return num
end
