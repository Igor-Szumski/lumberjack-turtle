-- static values
log = "minecraft:oak_log"
bone_meal = "minecraft:bone_meal"
sapling = "minecraft:oak_sappling"

-- functions
function check_block(direction)
  local success, data
  if direction == "up" then
    success, data = turtle.inspectUp()
  elseif direction == "down" then
    success, data = turtle.inspectDown()
  else
    success, data = turtle.inspect()
  end
  if success then
    return data.name
  end
end


function refuel() 
  -- refuel from logs is very inefficient (25% efficency)
  -- add Crafting module to the turtles, turn logs -> planks to make it 4x as efficient
  inventorySearch(log)
  fuelCount = turtle.getItemCount()
  turtle.refuel(fuelCount/10)
end

function harvest()
  while (turtle.getFuelLevel() < 200) do
    refuel()
  end

  turtle.dig()
  turtle.forward()
  while(check_block("up") == log) do
    turtle.digUp()
    turtle.up()
  end
  while(turtle.down()) do
    turtle.down()
  end
  turtle.back()
end

function is_grown()
  while check_block() ~= log do
    sleep(2)
    print('not a log')
  end
  return true
end

-- program 
while true do
  if is_grown() then
    harvest()
    -- add networking and send a msg to main computer saying that oak chests are full
    -- assert can have multiple parameters, can add function that will be executed if assert fails
    assert(turtle.dropDown(), "not enough space") 
  end
end