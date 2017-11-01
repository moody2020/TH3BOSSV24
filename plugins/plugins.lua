
do 

local update = 22; --  رقم اصدار السورس 

function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

 function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end


 function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end


 function exi_filez()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.json$')) then
            table.insert(files, v)
        end
    end
    return files
end

 function pl_exiz(name)
    for k,v in pairs(exi_filez()) do
        if name == v then
            return true
        end
    end
    return false
end



local function plugin_enabled( name ) 
  for k,v in pairs(_config.enabled_plugins) do 
    if name == v then 
      return k 
    end 
  end 
  return false 
end 

local function plugin_exists( name ) 
  for k,v in pairs(plugins_names()) do 
    if name..'.lua' == v then 
      return true 
    end 
  end 
  return false 
end 

local function list_all_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ☑️ enabled, ❌ disabled
    local status = '❌' 
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '☑️' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '*|☑️|>*'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'-'..status..'➟ '..check_markdown(v)..' \n'
    end
  end
  return text
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end 
local function enable_plugin( plugin_name ) 
  print('checking if '..plugin_name..' exists') 
  if plugin_enabled(plugin_name) then 
    return '🚸┇ الملف مفعل سابقا 👮🏻‍♀️\n➠ '..plugin_name..' ' 
  end 
  if plugin_exists(plugin_name) then 
    table.insert(_config.enabled_plugins, plugin_name) 
    print(plugin_name..' added to _config table') 
    save_config() 
    reload_plugins( )
    return '🚸┇ تم تفعيل الملف 👮🏻‍♀️\n➠ '..plugin_name..' ' 
  else 
    return '🚸┇ لا يوجد ملف بهذا الاسم ‼️\n➠ '..plugin_name..''
  end 
  
end 

local function disable_plugin( name, chat ) 
  if not plugin_exists(name) then 
    return '🚸┇ لا يوجد ملف بهذا الاسم ‼️ \n\n'
  end 
  local k = plugin_enabled(name) 
  if not k then 
    return '🚸┇ الملف معطل سابقا ♻️\n➠ '..name..' ' 
  end 
  table.remove(_config.enabled_plugins, k) 
  save_config( ) 
  reload_plugins( ) 
  return '🚸┇ تم تعطيل الملف ♻️\n➠ '..name..' ' 
end 


local function run(msg, matches) 
  if matches[1] == '/p' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end

    return list_all_plugins() 
  end 
  if matches[1] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end

    local plugin_name = matches[2] 
    print("enable: "..matches[2]) 
    return enable_plugin(plugin_name) 
  end 
  if matches[1] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end

    if matches[2] == 'plugins'  then 
       return '🛠عود انته لوتي تريد تعطل اوامر التحكم بالملفات 🌚' 
    end 
    print("disable: "..matches[2]) 
    return disable_plugin(matches[2]) 
  end 
  if (matches[1] == 'تحديث'  or matches[1]=="we") and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  plugins = {} 
  load_plugins() 
  return "🚸┇تم تحديث الملفات👮🏻‍♀️ ♻️"
  end 
  ----------------
   if (matches[1] == "sp" or matches[1] == "جلب ملف") and is_sudo(msg) then 
   if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end
     if (matches[2]=="الكل" or matches[2]=="all") then
   tdcli.sendMessage(msg.to.id, msg.id, 1, 'انتضر قليلا سوف يتم ارسالك كل الملفات📢', 1, 'html')

  for k, v in pairs( plugins_names( )) do  
      -- get the name 
      v = string.match (v, "(.*)%.lua") 
      		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..v..".lua", '🚸┇ الملف مقدم من قناه الـزعـيـم\n🚸┇ تابع قناه السورس @lBOSSl\n👨🏽‍🔧', dl_cb, nil)

  end 
else
local file = matches[2] 
  if not plugin_exists(file) then 
    return '🚸┇ لا يوجد ملف بهذا الاسم .\n\n'
  else 
      		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..v..".lua", '🚸┇ الملف مقدم من قناه  الـزعـيـم 🚸┇ \n🚸┇ تابع قناه السورس @lBOSSl\n👨🏽‍🔧', dl_cb, nil)
end
end
end

if (matches[1] == "dp" or matches[1] == "حذف ملف")  and matches[2] and is_sudo(msg) then 
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end

    disable_plugin(matches[2]) 
    if disable_plugin(matches[2]) == '🚸┇ لا يوجد ملف بهذا الاسم ‼️ \n\n' then
      return '🚸┇ لا يوجد ملف بهذا الاسم ‼️ \n\n'
      else
        text = io.popen("rm -rf  plugins/".. matches[2]..".lua"):read('*all') 
  return 'تم حذف الملف \n↝ '..matches[2]..'\n يا '..(msg.from.first_name or "erorr")..'\n'
 end
end 

if matches[1]:lower() == "ssp" and matches[2] and matches[3] then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end
local send_file = "./"..matches[2].."/"..matches[3]
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '🚸┇ الملف مقدم من قناه  الـزعـيـم 🚸┇ \n🚸┇ تابع قناه السورس @lBOSSl\n👨🏽‍🔧', dl_cb, nil)
end

if (matches[1] == 'رفع النسخه الاحتياطيه' or matches[1] == 'up') and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end
if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)
if data.content_.ID == 'MessageDocument' then
local doc_id = data.content_.document_.document_.id_
local filename = data.content_.document_.file_name_
local pathf = tcpath..'/data/document/'..filename
local cpath = tcpath..'/data/document'
if file_exi(filename, cpath) then
local pfile = "./data/moderation.json"
if (filename:lower():match('.json$')) then
file_dl(doc_id)
os.rename(pathf, pfile)
tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>ملف النسخه الاحتياطيه \n </b> <code>moderation.json</code> <b> تم رفعه في السورس</b>', 1, 'html')
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف ليس بصيغه json._', 1, 'md')
end
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_ارسل لملف مجددا واكتب الامر بالرد_', 1, 'md')
end
end

end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end

end

if (matches[1] == 'حفظ الملف' or matches[1] == 'save') and matches[2] and is_sudo(msg) then
     if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end

if tonumber(msg.reply_to_message_id_) ~= 0  then
function get_filemsg(arg, data)
function get_fileinfo(arg,data)

if data.content_.ID == 'MessageDocument' then
local doc_id = data.content_.document_.document_.id_
local filename = data.content_.document_.file_name_
local pathf = tcpath..'/data/document/'..filename
local cpath = tcpath..'/data/document'
if file_exi(filename, cpath) then
local pfile = "./plugins/"..matches[2]..".lua"
if (filename:lower():match('.lua$')) then
file_dl(doc_id)
os.rename(pathf, pfile)
reload_plugins( )
tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الملف </b> <code>'..matches[2]..'.lua</code> <b> تم رفعه في السورس</b>', 1, 'html')
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف ليس بصيغه lua._', 1, 'md')
end
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '_الملف تالف ارسل الملف مجددا._', 1, 'md')
end
end

end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
end
   
end

if (matches[1] == 'نسخه احتياطيه' or matches[1] == 'bu') and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end
i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
for k,v in pairsByKeys(data[tostring(groups)]) do
if data[tostring(v)] then
settings = data[tostring(v)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
i = i + 1
end
end
end


tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '🚸┇ الملف مقدم من قناه  الـزعـيـم 🚸┇ \n🚸┇ تابع قناه السورس @lBOSSl\n👨🏽‍🔧', dl_cb, nil)
if msg.to.type ~= 'pv' then
tdcli.sendMessage(msg.to.id, msg.id_, 1, 'تم ارسالك ملف نسخه الاحتياطيه للكروبات في الخاص', 1, 'md')
end

end

if (matches[1] == 'تحديث السورس' or matches[1] == 'update') and is_sudo(msg) then
if tonumber(msg.from.id) ~= tonumber(SUDO)  then return "☔️هذا الاوامر للمطور الاساسي فقط 🌑" end


--local dat, res = http.request('')
--local user = JSON.decode(dat)
--if user then
--if user.version == update then
--return"the source is alredy update"
--elseif user.version > update then
--return "loding to updating ... "
--tdcli.sendMessage(msg.to.id, msg.id_,1, 'loding to update the source ...', 1, 'html')

--sleep(10)
--download_to_file('','getuser.lua')
--reload_plugins( )
tdcli.sendMessage(msg.to.id, msg.id_,1, 'لا توجد تحديثات جديده.', 1, 'html')

--end
--else
--return "Errir for conected!"
end





	
	

if matches[1]:lower() == 'savefile' and matches[2] and is_sudo(msg) then
		if msg.reply_id  then
			local folder = matches[2]
            function get_filemsg(arg, data)
				function get_fileinfo(arg,data)
                    if data.content_.ID == 'MessageDocument' or data.content_.ID == 'MessagePhoto' or data.content_.ID == 'MessageSticker' or data.content_.ID == 'MessageAudio' or data.content_.ID == 'MessageVoice' or data.content_.ID == 'MessageVideo' or data.content_.ID == 'MessageAnimation' then
                        if data.content_.ID == 'MessageDocument' then
							local doc_id = data.content_.document_.document_.id_
							local filename = data.content_.document_.file_name_
                            local pathf = tcpath..'/data/document/'..filename
							local cpath = tcpath..'/data/document'
                            if file_exi(filename, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(doc_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>File</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>File</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessagePhoto' then
							local photo_id = data.content_.photo_.sizes_[2].photo_.id_
							local file = data.content_.photo_.id_
                            local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
							local cpath = tcpath..'/data/photo'
                            if file_exi(file..'_(1).jpg', cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(photo_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Photo</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Photo</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
		                if data.content_.ID == 'MessageSticker' then
							local stpath = data.content_.sticker_.sticker_.path_
							local sticker_id = data.content_.sticker_.sticker_.id_
							local secp = tostring(tcpath)..'/data/sticker/'
							local ffile = string.gsub(stpath, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(stpath, pfile)
                                file_dl(sticker_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Sticker</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Sticker</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageAudio' then
						local audio_id = data.content_.audio_.audio_.id_
						local audio_name = data.content_.audio_.file_name_
                        local pathf = tcpath..'/data/audio/'..audio_name
						local cpath = tcpath..'/data/audio'
							if file_exi(audio_name, cpath) then
								local pfile = folder
								os.rename(pathf, pfile)
								file_dl(audio_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Audio</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Audio</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
							else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
							end
						end
						if data.content_.ID == 'MessageVoice' then
							local voice_id = data.content_.voice_.voice_.id_
							local file = data.content_.voice_.voice_.path_
							local secp = tostring(tcpath)..'/data/voice/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(voice_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Voice</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Voice</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageVideo' then
							local video_id = data.content_.video_.video_.id_
							local file = data.content_.video_.video_.path_
							local secp = tostring(tcpath)..'/data/video/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(video_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Video</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Video</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageAnimation' then
							local anim_id = data.content_.animation_.animation_.id_
							local anim_name = data.content_.animation_.file_name_
                            local pathf = tcpath..'/data/animation/'..anim_name
							local cpath = tcpath..'/data/animation'
                            if file_exi(anim_name, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(anim_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Gif</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Gif</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
                    else
                        return
                    end
                end
                tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
            end
	        tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
        end
    end




end 

return { 
  patterns = { 
    "^/p$", 
    "^/p? (+) ([%w_%.%-]+)$", 
    "^/p? (-) ([%w_%.%-]+)$", 
    "^(sp) (.*)$", 
	"^(dp) (.*)$", 
	"^(حذف ملف) (.*)$",
  	"^(جلب ملف) (.*)$",
    "^(تحديث)$",
    "^(we)$",
    "^(نسخه احتياطيه)$",
    "^(bu)$",
    "^(up)$",
    "^(رفع نسخه احتياطيه)$",
    "^(ssp) ([%w_%.%-]+)/([%w_%.%-]+)$",
	"^(تحديث السورس)$",
	"^(update)$",
    "^(حفظ الملف) (.*)$",
	"^(savefile) (.*)$",
	"^(save) (.*)$",
 }, 
  run = run, 
  moderated = true, 
  --privileged = true 
} 

end 
