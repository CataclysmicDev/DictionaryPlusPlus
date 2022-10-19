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

local betterDictionary = setmetatable({}, {
    __call = function(_, dictionary)
        function dictionary:get(key)
            local function loop(_table)
                for k, v in pairs(_table) do
                    if k:upper() == key:upper() then
                        return v
                    end

                    if typeof(v) == "table" then
                        return loop(v)
                    end
                end
            end

            local value = loop(self)
            if value == nil then
                error("There was an error fetching key \""..key.."\"!")
            end
            
            return value
        end

        function dictionary:getKeyFromValue(value)
            local function loop(_table)
                for k, v in pairs(_table) do
                    if v == value then
                        return k
                    end
                    
                    if typeof(v) == "table" then
                        return loop(v)
                    end
                end
            end

            local value = loop(self)
            if value == nil then
                error("There was an error fetching value \""..value.."\"!")
            end
            
            return value
        end

        function dictionary:descend()
            local function loop(_table)
                for k, v in pairs(_table) do
                    if typeof(v) == "table" then
                        loop(v)
                        return {k, v}
                    end
                end
            end

            return loop(self)
        end

        function dictionary:add(key, value)
            self[key] = value
            return self
        end

        function dictionary:remove(key)
            self[key] = nil
            return self
        end

        function dictionary:wipe()
            for k, _ in pairs(self) do
                self[k] = nil
            end
        end

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

            descendDown(self)
            return array
        end

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

            descendDown(self)

            return array
        end

        function dictionary:replicate()
            return self
        end

        return dictionary
    end
})

return betterDictionary
