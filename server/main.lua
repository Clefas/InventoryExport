RegisterCommand('exportQS', function(source)
    print('Loading migration...')
    Inventory_Stash()
    Wait(5000)
    print('Stash migrated')
    print('Migrating Trunk')
    Inventory_Trunk()
    Wait(5000)
    print('Trunk migrated')
    print('Migrating Glovebox')
    Inventory_Glovebox()
    Wait(5000)
    print('Glovebox migrated')
end, true)

function Inventory_Stash()
    MySQL.Async.fetchAll('SELECT * FROM qs_stash', {}, function(result)
        if result ~= nil then
            for i=1, #result do
                local stashName = result[i].stash
                local stashItems = result[i].items
                if stashName and json.encode(stashItems) ~= '"[]"' then
                    MySQL.Async.execute('INSERT IGNORE INTO inventory_stash (stash, items) VALUES (@stash, @items)', {['@stash'] = stashName, ['@items'] = stashItems}, function(rowsAffected)
                        if rowsAffected == 0 then
                            print('Duplicate stash found:', stashName)
                        else 
                            print('Migrated Stash:', stashName)
                        end
                    end)
                end
            end
        end
    end)
end

function Inventory_Glovebox()
    MySQL.Async.fetchAll('SELECT * FROM qs_glovebox', {}, function(result)
        if result ~= nil then
            for i=1, #result do
                local stashName = result[i].plate
                local stashItems = result[i].items
                if stashName and json.encode(stashItems) ~= '"[]"' then
                    MySQL.Async.execute('INSERT IGNORE INTO inventory_glovebox (plate, items) VALUES (@plate, @items)', {['@plate'] = stashName, ['@items'] = stashItems}, function(rowsAffected)
                        if rowsAffected == 0 then
                            print('Duplicate stash found:', stashName)
                        else 
                            print('Migrated Glovebox:', stashName)
                        end
                    end)
                end
            end
        end
    end)
end

function Inventory_Trunk()
    MySQL.Async.fetchAll('SELECT * FROM qs_trunk', {}, function(result)
        if result ~= nil then
            for i=1, #result do
                local stashName = result[i].plate
                local stashItems = result[i].items
                if stashName and json.encode(stashItems) ~= '"[]"' then
                    MySQL.Async.execute('INSERT IGNORE INTO inventory_trunk (plate, items) VALUES (@plate, @items)', {['@plate'] = stashName, ['@items'] = stashItems}, function(rowsAffected)
                        if rowsAffected == 0 then
                            print('Duplicate stash found:', stashName)
                        else 
                            print('Migrated Trunk:', stashName)
                        end
                    end)
                end
            end
        end
    end)
end