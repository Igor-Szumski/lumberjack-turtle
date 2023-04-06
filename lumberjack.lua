function check_block() -- returns a minecraft block id from a block infront
  local success, data = turtle.inspect()
  if success then
    return data.name
  end
end

function check_block_up() -- returns a minecraft block id from a block on top of turtle
  local success, data = turtle.inspectUp()
  if success then
    return data.name
  end
end

function inventory_search(lookingFor)
  print(lookingFor)
  for i=1,16 do -- itterate through inventory to get selected block
    turtle.select(i)
    local selectedItem = turtle.getItemDetail()
    if selectedItem then
      selectedItem = selectedItem.name
    end
    if selectedItem == lookingFor then
      return true
    end
  end
end

function refuel()
  inventory_search(log)
  fuelCount = turtle.getItemCount()
  turtle.refuel(fuelCount/10)
end


log = "minecraft:oak_log"
sapling = "minecraft:oak_sapling"
boneMeal = "minecraft:bone_meal"

function main()
  blockIs = check_block()
  if blockIs == log then
    chopchop()
    elseif blockIs == sapling then
      if(inventory_search(boneMeal)) then
        while(turtle.place()) do
          turtle.place()
        end
        main()
      end
    else
      if(inventory_search(sapling)) then
        turtle.place()
        main()
      end
  end
end

function operation_decider()
  lookingAt = check_block()
  if lookingAt == log then
    chopchop()

function chopchop()
  if (turtle.getFuelLevel() < 300) then
    refuel()
  end

  turtle.dig()
  turtle.forward()
  while(check_block_up() == log) do
    turtle.digUp()
    turtle.up()
  end
  while(turtle.down()) do
    turtle.down()
  end
  turtle.back()
  main()
end

-- start
main()
