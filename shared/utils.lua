Utils = {}

function Utils.Round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function Utils.GetCurrentTime()
    return os.time()
end

function Utils.CalculateDistance(coords1, coords2)
    return #(
