--Copyright & Licensing
--[[
MIT License

Copyright (c) 2022 CataclysmicDev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

--Version: 1.0.0

local dictionaryPlusPlus = setmetatable({}, {
    __call = function(_, elements)
        --(When using the word self I mean to say the current dictionary)
        --(k/v = key/value)
        local dictionary = {
            UserCreated = elements
        }

        --Loops through all of self and returns "v" where v is equal to the value of the key passed
        function dictionary:get(key)
            local dictionariesToLoop = {}
            local dic = 0

            local function loop(_table)
                for k, v in pairs(_table) do
                    if k:upper() == key:upper() then
                        return v
                    end

                    if typeof(v) == "table" then
                        table.insert(dictionariesToLoop, v)
                    end
                end

                dic += 1

                if #dictionariesToLoop > 0 then
                    return loop(dictionariesToLoop[dic])
                end
            end

            local value = loop(self.UserCreated)
            if value == nil then
                error("There was an error fetching key \""..key.."\"!")
            end
            
            return value
        end

        --Loops through every single value inside of self
        function dictionary:descendValues()
            local list = {}
            local function loop(_table)
                for _, v in pairs(_table) do
                    if typeof(v) == "table" then
                        loop(v)
                        continue
                    end

                    table.insert(list, v)
                end
            end

            loop(self.UserCreated)
            return list
        end

        --Loops through every single key inside of self
        function dictionary:descendKeys()
            local list = {}
            local function loop(_table)
                for k, v in pairs(_table) do
                    if typeof(v) == "table" then
                        loop(v)
                        continue
                    end

                    table.insert(list, k)
                end
            end

            loop(self.UserCreated)
            return list
        end

        --Adds a new key with a value(key/value are inputs)
        function dictionary:add(key, value)
            self.UserCreated[key] = value
        end

        --Removes the given key
        function dictionary:remove(key)
            self.UserCreated[key] = nil
            return self
        end

        --Erases self and returns empty dictionary({})
        function dictionary:wipe()
            for k, _ in pairs(self) do
                self.UserCreated[k] = nil
            end
        end

        --Returns an array which elements are equal to the keys of every single element in self
        function dictionary:convertKeys()
            local array = {}
            local function descendDown(_table)
                for k, v in pairs(_table) do
                    if typeof(k) == "table" then
                        descendDown(v)
                        continue
                    end
    
                    table.insert(array, k)
                end 
            end

            descendDown(self.UserCreated)
            return array
        end

        --Returns an array which elements are equal to the values of every single element in self
        function dictionary:convertValues()
            local array = {}
            local function descendDown(_table)
                for k, v in pairs(_table) do
                    if typeof(k) == "table" then
                        descendDown(v)
                        continue
                    end

                    table.insert(array, v)
                end 
            end

            descendDown(self.UserCreated)

            return array
        end

        --Returns the count of the elements created
        function dictionary:count()
            local elements = 0
            local function loop(_table)
                for _, v in pairs(_table) do
                    elements += 1

                    if typeof(v) == "table" then
                        loop(v)
                        continue
                    end
                end
            end

            loop(self.UserCreated)

            return elements
        end

        --Returns everything in self
        function dictionary:replicateEverything()
            return self
        end

        --Returns user content in self
        function dictionary:replicateCreated()
            return self.UserCreated
        end

        return dictionary
    end
})

return dictionaryPlusPlus
