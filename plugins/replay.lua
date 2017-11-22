do 
local function run(msg, matches) 

if is_silent_user(msg.from.id, msg.to.id) then return end

local w = matches[1]
local ww = matches[2]
local r3 = matches[3]
local r4 = matches[4]
local name_user = string.sub(msg.from.first_name:lower(),0,60) 
 data = load_data(_config.moderation.data)
if msg.from.username then
usernamex = "@"..(msg.from.username or "---")
else
usernamex = "️ ما مسوي  😹💔 "
end

--------------[data function to save rdod ]---------------
if data[tostring(msg.to.id)] then
if data[tostring(msg.to.id)]['settings'] then
settings = data[tostring(msg.to.id)]['settings'] 
if data[tostring(msg.to.id)]['settings']['replay'] then
lock_reply = data[tostring(msg.to.id)]['settings']['replay']  
elseif not data[tostring(msg.to.id)]['settings']['replay'] then
lock_reply = "🔓"
end end end
---------------[bot out]---------------------------

if w==bot_name and ww== 'غادر' and is_sudo(msg) then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك باي 😢💔🖇', 1, 'html')
botrem(msg)
end   
-------[/start and welcom and save user id ]-----------
if w=="المشتركين" and is_sudo(msg) and msg.to.type == 'pv'  then
  local users = '◈￤ عدد المشتركين  `'..redis:scard('users')..'` *مشترك في البوت *🍃'
return users
end

if w=="/start" and msg.to.type == 'pv'  then
 redis:sadd('users',msg.from.id)
return [[◈￤مرحبا انا بوت 
◈￤اختصاصي حمايه كروبات
◈￤من السبام والوسائط والتكرار والخ...
◈￤فقط المطور يفعل البوت
◈￤مطور البوت : ]]..sudouser..[[

👨🏽‍🔧]]
end
if (msg.to.type == "pv") and not is_sudo(msg) then
tdcli.sendMessage(msg.to.id, 0, 1, "◈￤ تم ارسال رسالتك الى المطور\n◈￤ـ "..sudouser.."\n◈￤ سوف ارد عليك في اقرب وقت\n👨🏻‍🔧", 1, '')
tdcli.forwardMessages(SUDO,msg.to.id, {[0] = msg.id}, 0)

end


---------------[End Function data] -----------------------
---------------[End Function data] -----------------------
if w=="اضف رد" then
if not is_owner(msg) then return"◈￤ للمدراء فقط ! 🖇" end
redis:set('addrd:'..msg.from.id, true)
redis:del("replay1")
redis:del("replay2")
redis:del('addrd2:'..msg.from.id)
return "📭 ┇ _حسنأ الان ارسل كلمة الرد _🍃\n"
end

if w=="اضف رد للكل" then
if not is_sudo(msg) then return"◈￤ للمطورين فقط ! 🖇" end
redis:set('addrdall:'..msg.from.id, true)
redis:del("allreplay1")
redis:del("allrepaly2")
redis:del('addrdall2:'..msg.from.id)
return "📭 ┇ _حسنأ الان ارسل كلمة الرد العام _🍃\n"
end

if msg.text then

if redis:get('addrdall:'..msg.from.id) and is_owner(msg) then
if  not redis:get('allreplay1') then
redis:set('allreplay1',msg.text)
redis:set('addrdall2:'..msg.from.id,true)
return "◈￤ _شكرأ لك 😻_\n ◈￤ _الان ارسل جواب الرد _☑️" 
end
if redis:get('addrdall2:'..msg.from.id) then
  redis:set('allrepaly2',msg.text)
 if not data['replay_all'] then
    data['replay_all'] = {}
    save_data(_config.moderation.data, data)
    end
data['replay_all'][redis:get("allreplay1")] = redis:get("allrepaly2")
save_data(_config.moderation.data, data)
redis:del('addrdall:'..msg.from.id)
return '('..redis:get('allreplay1')..')\n  ☑️ تم اضافت الرد لكل المجموعات 🚀 '
end
end

if redis:get('addrd:'..msg.from.id) and is_owner(msg) then
if  not redis:get('replay1') then
redis:set('replay1',msg.text)
redis:set('addrd2'..msg.from.id,true)
return "◈￤ _شكرأ لك 😻_\n ◈￤ _الان ارسل جواب الرد _☑️" 
end
if redis:get('addrd2'..msg.from.id) then
  redis:set('replay2',msg.text)
data[tostring(msg.to.id)]['replay'][redis:get("replay1")] = redis:get("replay2")
save_data(_config.moderation.data, data)
redis:del('addrd:'..msg.from.id)
return '('..redis:get('replay1')..')\n  ☑️ تم اضافت الرد 🚀 '
end
end
end



if w == 'مسح الردود' then
if not is_owner(msg) then return"◈￤ للمدراء فقط ! 🖇" end

if next(data[tostring(msg.to.id)]['replay']) == nil then
return  " عذراً 🌝".. ":{" ..msg.from.first_name.. "}:".."\n".."\n".." 🗯قائمة الردود فارغة بالفعل 🖇 "
else
for k,v in pairs(data[tostring(msg.to.id)]['replay']) do
data[tostring(msg.to.id)]['replay'][tostring(k)] = nil
save_data(_config.moderation.data, data)
end
return "☑️ تم مسح كل الردود 🚀"
end
end

if w == 'مسح الردود العامه' then
if not is_sudo(msg) then return"◈￤ للمطورين فقط ! 🖇" end

if next(data['replay_all']) == nil then
return  " عذراً 🌝".. ":{" ..msg.from.first_name.. "}:".."\n".."\n".." ◈￤ قائمة الردود العامه فارغة بالفعل 🖇 "
else
for k,v in pairs(data['replay_all']) do
data['replay_all'][tostring(k)] = nil
save_data(_config.moderation.data, data)
end
return "☑️ تم مسح كل الردود العامه🚀"
end
end

if w == 'مسح رد عام' then
if not is_sudo(msg) then return"◈￤ للمطورين فقط ! 🖇" end

if not data['replay_all'][ww] then
return '◈￤ هذا الرد ليس مضاف في قائمه الردود 🖇'
else
data['replay_all'][ww] = nil
save_data(_config.moderation.data, data)
return '('..ww..')\n  ☑️ تم مسح الرد 🚀 '
end
end

if w == 'مسح رد' then
if not is_owner(msg) then return"◈￤ للمدراء فقط ! 🖇" end

if not data[tostring(msg.to.id)]['replay'][ww] then
return '◈￤ هذا الرد ليس مضاف في قائمه الردود 🖇'
else
data[tostring(msg.to.id)]['replay'][ww] = nil
save_data(_config.moderation.data, data)
return '('..ww..')\n  ☑️ تم مسح الرد 🚀 '
end
end




if w == 'الردود' then
if next(data[tostring(msg.to.id)]['replay']) ==nil then
return '◈￤ لايوجد ردود مضافه حاليا ❗️'
else
local i = 1
local message = '◈￤ ردود البوت في المجموعه  🖇\n\n'
for k,v in pairs(data[tostring(msg.to.id)]['replay']) do
message = message ..i..' - ('..k..') \n'
i = i + 1
end
return message
end

end
if w == 'الردود العامه' then
if next(data['replay_all']) ==nil then
return '◈￤ لايوجد ردود مضافه حاليا ❗️'
else
local i = 1
local message = '◈￤ ردود العامه في البوت  🖇\n\n'
for k,v in pairs(data['replay_all']) do
message = message ..i..' - ('..k..') \n'
i = i + 1
end
return message
end

end



--------------------[Test Bot]----------------------------
if w =="تيست" then
return "🖇 البوت شـغــال 🚀"
elseif w == "اسمي" then
return  "\n" ..msg.from.first_name.."\n" 
elseif w == "معرفي" then
return  "@"..(msg.from.username or "لايوجد").."\n" 
elseif w == "رقمي" then
return  "\n"..(msg.from.phone or "لايوجد").."\n" 
elseif w == "ايديي" then
return  "\n"..msg.from.id.."\n" 
elseif w =="صورتي" then
local function getpro(arg, data)
if data.photos_[0] then
local rank
if is_sudo(msg) then
rank = 'المطور مالتي 😻'
elseif is_owner(msg) then
rank = 'مدير المجموعه 😽'
elseif is_mod(msg) then
rank = ' ادمن في البوت 😺'
elseif is_whitelist(msg.from.id,msg.to.id)  then
rank = 'عضو مميز 🎖'
else
rank = 'مجرد عضو 😹'
end
tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,"",dl_cb,nil)
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "◈￤ لا يوجد صوره في بروفايلك ...", 1, 'md')
end end
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.from.id,offset_ = 0,limit_ = 1}, getpro, nil)
elseif w=="اريد رابط الحذف" or w=="اريد رابط حذف" or w=="رابط حذف" or w=="رابط الحذف" then
return [[
◈￤ - رابط حذف التلي ⬇️ :
◈￤ - احذف ولا ترجع عيش حياتك 😪💔
◈￤ - https://telegram.org/deactivate
]] 
elseif w== 'ايدي' and msg.to.type == 'pv' then
return "◈￤ ايدي البوت : "..our_id.. "\n\n ◈￤ ايدي حسابك : "..msg.from.id.. "\n ◈￤مـطـور الـسـورس\n الزعيم محمد  > @TH3BOSS "
elseif w=="رتبتي" then
local rank
if is_sudo(msg) then
rank = 'المطور مالتي 😻'
elseif is_owner(msg) then
rank = 'مدير المجموعه 😽'
elseif is_mod(msg) then
rank = ' ادمن في البوت 😺'
elseif is_whitelist(msg.from.id,msg.to.id)  then
rank = 'عضو مميز 🎖'
else
rank = 'مجرد عضو 😹'
end
return '◈￤ رتبتك : '..rank
end


if lock_reply =="🔒" and  data[tostring(msg.to.id)]    then

if ( msg.text ) and ( msg.to.type == "channel" ) or ( msg.to.type == "chat" ) then
----------------------
local su = {
"نعم حبيبي المطور 🌝❤",
"يابعد روح "..bot_name.." 😘❤️",
"هلا بمطوري العشق أمرني"
}
local  ss97 = {
"ها حياتي😻",
"عيونه 👀 وخشمه 👃🏻واذانه👂🏻",
"باقي ويتمدد 😎",
"ها حبي 😍",
"ها عمري 🌹",
"اجيت اجيت كافي لتصيح 🌚👌",
"هياتني اجيت 🌚❤️",
"نعم حبي 😎",
"هوه غير يسكت عاد ها شتريد 😷",
"احجي بسرعه شتريد 😤",
"ها يا كلبي ❤️",
"هم صاحو عليه راح ابدل اسمي من وراكم 😡",
"لك فداك "..bot_name.." حبيبي انت اموووح 💋",
"دا اشرب جاي تعال غير وكت 😌",
"كول حبيبي أمرني 😍",
"احجي فضني شرايد ولا اصير ضريف ودكلي جرايد لو مجلات تره بايخه 😒😏",
"اشتعلو اهل "..bot_name.." شتريد 😠",
"بووووووووو 👻 ها ها فزيت شفتك شفتك لا تحلف 😂",
"طالع مموجود 😒",
"هااا شنوو اكو حاته بالكروب وصحت عليه  😍💕",
"انت مو قبل يومين غلطت عليه؟  😒",
"راجع المكتب حبيبي عبالك "..bot_name.." سهل تحجي ويا 😒",
"ياعيون "..bot_name.." أمرني 😍",
"لك دبدل ملابسي اطلع برااااا 😵😡 ناس متستحي",
"سويت هواي شغلات سخيفه بحياتي بس عمري مصحت على واحد وكلتله انجب 😑",
"مشغول ويا ضلعتي  ☺️",
"مازا تريد منه 😌🍃",

}
local bs = {
"مابوس 🌚💔",
"اآآآم͠ــ.❤️😍ــو͠و͠و͠آ͠آ͠ح͠❤️عسسـل❤️",
"الوجه ميساعد 😐✋",
"ممممح😘ححح😍😍💋",
}
local ns = {
"🌹 هــلــℌelℓoووات🌹عمـ°🌺°ــري🙊😋",
"هْـٌﮩٌﮧٌ﴿🙃﴾ﮩٌـ୭ٌ୭ـْلوُّات†😻☝️",
"هلاوو99وووات نورت/ي ❤️🙈",
"هلووات 😊🌹",
}
local sh = {
"اهلا عزيزي المطور 😽❤️",
"هلوات . نورت مطوري 😍",
}
local lovs =  "اموت عليك حياتي  😍❤️"
local  lovm = {
"اكرهك 😒👌🏿",
"دي 😑👊🏾",
"اعشكك/ج مح 😍💋",
"اي احبك/ج 😍❤️",
"ماحبك/ج 😌🖖",
"امـــوت فيك ☹️",
"اذا كتلك/ج احبك/ج شراح تستفاد/ين 😕❤️",
"ولي ماحبك/ج 🙊💔",
}
local thb = {
"اموت عليه-ه 😻😻",
"فديته-ه 😍❤️",
"لا ماحبه-ه 🌚💔",
"اكرهه 💔🌚",
"يييع 😾👊🏿",
"مادري افڱﮩﮩﮩر🐸💔"
}
local song = {
"عمي يبو البار 🤓☝🏿️ \nصبلي لبلبي ترى اني سكران 😌 \n وصاير عصبي 😠 \nانه وياج يم شامه 😉 \nوانه ويــــاج يم شامه  شد شد  👏🏿👏🏿 \nعدكم سطح وعدنه سطح 😁 \n نتغازل لحد الصبح 😉 \n انه وياج يم شامه 😍 \n وانه وياج فخريه وانه وياج حمديه 😂🖖🏿\n ",
"اي مو كدامك مغني قديم 😒🎋 هوه ﴿↜ انـِۨـۛـِۨـۛـِۨيـُِـٌِہۧۥۛ ֆᵛ͢ᵎᵖ ⌯﴾❥  ربي كامز و تكلي غنيلي 🙄😒🕷 آإرۈحُـ✯ـہ✟  😴أنــ💤ــااااام😴  اشرف تالي وكت يردوني اغني 😒☹️🚶",
"لا تظربني لا تظرب 💃💃 كسرت الخيزارانه💃🎋 صارلي سنه وست اشهر💃💃 من ظربتك وجعانه🤒😹",
"موجوع كلبي😔والتعب بية☹️من اباوع على روحي😢ينكسر كلبي عليه😭",
"ايامي وياها👫اتمنا انساها😔متندم اني حيل😞يم غيري هيه💃تضحك😂عليه😔مقهور انام الليل😢كاعد امسح بل رسائل✉️وجان اشوف كل رسايلها📩وبجيت هوايه😭شفت احبك😍واني من دونك اموت😱وشفت واحد 🚶صار هسه وياية👬اني رايدها عمر عمر تعرفني كل زين🙈 وماردت لا مصلحة ولاغايه😕والله مافد يوم بايسها💋خاف تطلع🗣البوسه💋وتجيها حجايه😔️",
"😔صوتي بعد مت سمعه✋يال رايح بلا رجعة🚶بزودك نزلت الدمعة ذاك اليوم☝️يال حبيتلك ثاني✌روح وياه وضل عاني😞يوم اسود علية اني🌚 ذاك اليوم☝️تباها بروحك واضحك😂لان بجيتلي عيني😢😭 وافراح يابعد روحي😌خل الحركة تجويني😔🔥صوتي بعد متسمعة🗣✋",


}
-------reply By stickers -------

local sound = {
"data/audio/aml_mnk.ogg",
"data/audio/mozeka.ogg"
}
local function sudoname(ww)
if string.match(ww, 'محمد')  or  string.match(ww, 'حموش') or  string.match(ww, 'حمودي') or  string.match(ww, 'حمود')  or string.match(ww, 'حموش') then
return true
else
return false
end
end

----------------------------------------------
if is_sudo(msg) and w == bot_name and not ww then 
return  su[math.random(#su)]  
elseif not is_sudo(msg) and w == bot_name and not ww then 
return  ss97[math.random(#ss97)]  
elseif w == "كول" and ww then
if string.len(ww) > 60 then return "◈￤ ما اكدر اكول اكثر من 60 حرف 🙌🏾" end
if sudoname(ww) then return "◈￤ ما اكدر احجي عليه مستحيل 🕵🏻" end
if ww:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or ww:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or ww:match("[Tt].[Mm][Ee]/") or ww:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or ww:match(".[Pp][Ee]") or ww:match("[Hh][Tt][Tt][Pp][Ss]://") or ww:match("[Hh][Tt][Tt][Pp]://") or ww:match("[Ww][Ww][Ww].") or ww:match(".[Cc][Oo][Mm]") or ww:match("@") then
return "انته لوتي عود ؟ هو اني نغل ههه يريدني انشر رابط او معرف 😪 " 
end
return tdcli.sendMessage(msg.to.id, 0, 1, '<code>'..ww..'</code>', 1, 'html')
elseif w == "كله" and ww then
if string.len(ww) > 60 then return "◈￤ ما اكدر اكله اكثر من 60 حرف 🙌🏾" end
if sudoname(ww) then return "◈￤ ما اكدر احجي عليه مستحيل 🕵🏻" end
if ww:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or ww:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or ww:match("[Tt].[Mm][Ee]/") or ww:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or ww:match(".[Pp][Ee]") or ww:match("[Hh][Tt][Tt][Pp][Ss]://") or ww:match("[Hh][Tt][Tt][Pp]://") or ww:match("[Ww][Ww][Ww].") or ww:match(".[Cc][Oo][Mm]") or ww:match("@") then
return "انته لوتي عود ؟ هو اني نغل ههه يريدني انشر رابط او معرف 😪 " 
end
if msg.reply_id then
return tdcli.sendMessage(msg.to.id, msg.reply_id, 1, '<code>'..ww..'</code>', 1, 'html')
end
elseif w == "اتفل" and ww then
if sudoname(ww) then return "◈￤ ما اكدر اتفل عليه مستحيل 🕵🏻" end
if msg.reply_id then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك سيدي 🌝🍃', 1, 'html')
tdcli.sendMessage(msg.to.id, msg.reply_id, 1, 'ختفوووووووووو💦💦️️', 1, 'html')
else 
return"  🕵🏻 وينه بله سويله رد 🙄"
end
elseif w == ""..bot_name.." رزله" and ww and is_sudo(msg) then
if msg.reply_id then
tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك سيدي 🌝🍃', 1, 'html')
tdcli.sendMessage(msg.to.id, msg.reply_id, 1, 'يا ول شو طالعة عينك😒 من البنات مو😪و هم صايرلك لسان تحجي😠اشو تعال👋👊صير حباب مرة ثانية ترةة ...😉و لا تخليني البسك عمامة و اتفل عليك😂️', 1, 'html')
end
elseif w == "بوس" and ww then 
if sudoname(ww) then
return " امممح عـﮩـموري┇🎵™ هذا العشق😻💋"
else
if msg.reply_id then
return  bs[math.random(#bs)] 
else
return "📌 وينه بله سويله رد 🕵🏻"
end
end
elseif w == "تحب" and ww then
if sudoname(ww) then
return "اموت عليةة حمودي┇🎵™ هذا العشق😻💋"
else
return  thb[math.random(#thb)] 
end
elseif is_sudo(msg) and w =="هلو" then
return  sh[math.random(#sh)]  
elseif not is_sudo(msg) and w =="هلو" then
return  ns[math.random(#ns)]  
elseif is_sudo(msg) and w == "احبك" then
return  lovs
elseif is_sudo(msg) and w == "تحبني" or w=="حبك"  then
return  lovs
elseif not is_sudo(msg) and w == "احبك" or w=="حبك" then
return  lovm[math.random(#lovm)]  
elseif not is_sudo(msg) and w == "تحبني" then
return  lovm[math.random(#lovm)]  
elseif w== "زعيم"  then
return  ss97[math.random(#ss97)]  
elseif w== "غني" or w=="غنيلي" then
return  song[math.random(#song)] 
elseif w=="اتفل" or w=="تفل" then
if is_mod(msg) then return 'ختفوووووووووو💦💦️️' else return "📌 انجب ما اتفل عيب 😼🙌🏿" end
elseif w== "تف" then
return  "عيب ابني/بتي اتفل/ي اكبر منها شوية 😌😹"
elseif w== "شلونكم" or w== "شلونك" or w== "شونك" or w== "شونكم"   then
return  "احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚"
elseif w== "صاكه"  then
return  "اووويلي يابه 😍❤️ دزلي صورتهه 🐸💔"
elseif w== "وينك"  then
return   "دور بكلبك وتلكاني 😍😍❤️"
elseif w== "منورين"  then
return  "من نورك عمري ❤️🌺"
elseif w== "هاي"  then
return  "هايات عمري 😍🍷"
elseif w== "🙊"  then
return  "فديت الخجول 🙊 😍"
elseif w== "😢"  then
return  "لتبجي حياتي 😢"
elseif w== "😭"  then
return  "لتبجي حياتي 😭😭"
elseif w== "منور"  then
return  "نِْـِْـــِْ([💡])ِْــــًِـًًْـــِْـِْـِْـورِْكِْ"
elseif w== "😒" and not is_sudo then
return  "شبيك-ج عمو 🤔"
elseif w== "مح"  then
return  "محات حياتي🙈❤"
elseif w== "شكرا" or w== "ثكرا" then
return  "{ •• الـّ~ـعـفو •• }"
elseif w== "انته وين"  then
return  "بالــبــ🏠ــيــت"
elseif w== "😍"  then
return  " يَمـه̷̐ إآلُحــ❤ــب يَمـه̷̐ ❤️😍"
elseif w== "اكرهك"  then
return  "ديله شلون اطيق خلقتك اني😾🖖🏿🕷"
elseif w== "اريد اكبل"  then
return  "خخ اني هم اريد اكبل قابل ربي وحد😹🙌️"
elseif w== "باي" or w=="بااي" or w=="باااي" or w=="بااااي" then
return  "بايات حياتي ❤️ " ..name_user.."\n"
elseif w== "ضوجه"  then
return  "شي اكيد الكبل ماكو 😂 لو بعدك/ج مازاحف/ة 🙊😋"
elseif w== "اروح اصلي"  then
return  "انته حافظ سوره الفاتحة😍❤️️"
elseif w== "صاك"  then
return  "زاحفه 😂 منو هذا دزيلي صورهه"
elseif w== "اجيت" or w=="اني اجيت" then
return  "كْـٌﮩٌﮧٌ﴿😍﴾ـﮩٌول الـ୭ـهـٌ୭ـْلا❤️"
elseif w== "طفي السبلت"  then
return  "تم اطفاء السبلت بنجاح 🌚🍃"
elseif w== "شغل السبلت"  then
return  "تم تشغيل السبلت بنجاح بردتو مبردتو معليه  🌚🍃"
elseif w== "حفلش"  then
return  "افلش راسك 🤓"
elseif w=="نايمين" then
return  "ني سهران احرسكـم😐🍃'"
elseif w=="اكو احد" then
return  "يي عيني انـي موجـود🌝🌿"
elseif w=="شكو" then
return  "كلشي وكلاشي🐸تگـول عبالك احنـة بالشورجـة🌝"
elseif w=="انتة منو" then
return  "آني كـامل مفيد اكبر زنگين أگعدة عالحديـد🙌"
elseif w=="كلخرا" then
return  "خرا ليترس حلكك/ج ياخرا يابنلخرا خختفووو ابلع😸🙊💋"
elseif w== "حبيبتي"  then
return  "منو هاي 😱 تخوني 😔☹"
elseif w== "حروح اسبح"  then
return  "واخيراً 😂"
elseif w== "😔"  then
return  "ليش الحلو ضايج ❤️🍃"
elseif w== "☹️"  then
return  "لضوج حبيبي 😢❤️🍃"
elseif w== "جوعان"  then
return  "تعال اكلني 😐😂"
elseif w== "تعال خاص" or w== "خاصك" or w=="شوف الخاص" or w=="شوف خاص" then
return  "ها شسون 😉"
elseif w== "لتحجي"  then
return  "وانت شعليك حاجي من حلگگ😒"
elseif w== "معليك" or w== "شعليك" then
return  "عليه ونص 😡"
elseif w== "شدسون" or w== "شداتسوون" or w== "شدتسون" then
return  "نطبخ 😐"
elseif w== bot_name and ww=="شلونك"  then
return "احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚"
elseif w== "يومه فدوه"  then
return  "فدؤه الج حياتي 😍😙"
elseif w== "افلش"  then
return  "باند عام من 30 بوت 😉"
elseif w== "احبج"  then
return  "يخي احترم شعوري 😢"
elseif w== "شكو ماكو"  then
return  "غيرك/ج بل كلب ماكو يبعد كلبي😍❤️️"
elseif w== "اغير جو"  then
return  "😂 تغير جو لو تسحف 🐍 عل بنات"
elseif w== "😋"  then
return  "طبب لسانك جوه عيب 😌"
elseif w== "😡"  then 
return  "ابرد  🚒"  
elseif w== "مرحبا"  then
return  "مراحب 😍❤️ نورت-ي 🌹"
elseif w== "سلام" or w== "السلام عليكم" or w== "سلام عليكم" or w=="سلامن عليكم" or w=="السلامن عليكم" then
return  "وعليكم السلام اغاتي🌝👋" 
elseif w== "واكف"  then
return  "يخي مابيه شي ليش تتفاول😢" 
elseif w== "🚶🏻"  then
return  "لُـﮩـضڵ تتـمشـﮥ اڪعـد ﺳـﯠڵـف 🤖👋🏻"
elseif w== "البوت واكف"  then
return  "هياتني 😐"
elseif w == "ضايج"  then 
return  "ليش ضايج حياتي"
elseif w== "ضايجه"  then
return  "منو مضوجج كبدايتي"
elseif w== "😳" or w== "😳😳" or w== "😳😳😳" then
--return  "ها بس لا شفت خالتك الشكره 😳😹🕷"
elseif w== "صدك"  then
return  "قابل اجذب عليك!؟ 🌚"
elseif w== "شغال"  then
return  "نعم عزيزي باقي واتمدد 😎🌿"
elseif w== "تخليني"  then
return  "اخليك بزاويه 380 درجه وانته تعرف الباقي 🐸"
elseif w== "فديتك" or w== "فديتنك"  then
return  "فداكـ/چ ثولان العالـم😍😂" 
elseif w== "بوت"  then
return  "أسمي "..bot_name.." 🌚🌸"
elseif w== "مساعدة"  then
return  "لعرض قائمة المساعدة اكتب الاوامر 🌚❤️"
elseif w== "زاحف"  then
return  "زاحف عله خالتك الشكره 🌝"
elseif w== "حلو"  then
return  "انت الاحلى 🌚❤️"
elseif w== "تبادل"  then
return  "كافي ملينه تبادل 😕💔"
elseif w== "عاش"  then
return  "الحلو 🌝🌷"
elseif w== "مات"  then
return  "أبو الحمامات 🕊🕊"
elseif w== "ورده" or w== "وردة"  then
return  "أنت/ي  عطرها 🌹🌸"
elseif w== "شسمك"  then
return  "مكتوب فوك 🌚🌿"
elseif w== "فديت" or w=="فطيت" then
return  "فداك/ج 💞🌸"
elseif w== "واو"  then
return  "قميل 🌝🌿"
elseif w== "زاحفه" or w== "زاحفة"  then
return  "لو زاحفتلك جان ماكلت زاحفه 🌝🌸"
elseif w== "حبيبي" or w=="حبي"  then
return  "بعد روحي 😍❤️ تفضل"
elseif w== "حبيبتي"  then
return  "تحبك وتحب عليك 🌝🌷"
elseif w== "حياتي"  then
return  "ها حياتي 😍🌿"
elseif w== "عمري"  then
return  "خلصته دياحه وزحف 🌝🌿 "
elseif w== "اسكت"  then
return  "وك معلم 🌚💞"
elseif w== "بتحبني"  then
return  "بحبك اد الكون 😍🌷"
elseif w== "المعزوفه" or w=="المعزوفة" or w=="معزوفه" then
return  "طرطاا طرطاا طرطاا 😂👌"
elseif w== "موجود"  then
return  "تفضل عزيزي 🌝🌸"
elseif w== "اكلك"  then
return  ".كول حياتي 😚🌿"
elseif w== "فدوه" or w=="فدوة" or w=="فطوه" or w=="فطوة" then      
return  "لكلبك/ج 😍❤️"
elseif w== "دي"  then
return  "خليني احہۣۗبہۜۧ😻ہہۖۗڱֆ ̮⇣  🌝💔"
elseif w== "اشكرك"  then
return  "بخدمتك/ج حبي ❤"
elseif w== "😉"  then
return  "😻🙈"
elseif w== "اقرالي دعاء"  then
return "اللهم عذب المدرسين 😢 منهم الاحياء والاموات 😭🔥 اللهم عذب ام الانكليزي 😭💔 وكهربها بلتيار الرئيسي 😇 اللهم عذب ام الرياضيات وحولها الى غساله بطانيات 🙊 اللهم عذب ام الاسلاميه واجعلها بائعة الشاميه 😭🍃 اللهم عذب ام العربي وحولها الى بائعه البلبي اللهم عذب ام الجغرافيه واجعلها كلدجاجه الحافية اللهم عذب ام التاريخ وزحلقها بقشره من البطيخ وارسلها الى المريخ اللهم عذب ام الاحياء واجعلها كل مومياء اللهم عذب المعاون اقتله بلمدرسه بهاون 😂😂😂"
elseif msg.edited and not is_sudo(msg) and settings.lock_edit =="🔓" then
return "سحك وعدل 😹☝🏿"
-------------- صوتيات
elseif w == "ابجي" then
--send_document(get_receiver(msg), "data/stickers/ebke.webp", ok_cb, false)
elseif w == "اضحك" then
--send_document(get_receiver(msg), funstickers[math.random(#funstickers)], ok_cb, false)
elseif w == ""..bot_name.." عفط" and ww and msg.reply_id and is_sudo(msg) then
if msg.reply_id then
return tdcli.sendVoice(msg.chat_id_, msg.reply_id, 0, 1, nil, 'data/audio/zeg.ogg', nil, nil, '◈￤ اسمع الزيج  اسمع 🔊')
end
elseif w == ""..bot_name.." بوس" and ww and msg.reply_id and is_sudo(msg) then
if msg.reply_id then
return tdcli.sendAnimation(msg.to.id, msg.reply_id, 0, 1, nil, "data/photo/bos.mp4", nil, nil, 'مح 💋')  
end
---------------------------------------------
elseif w == "انجب" or w == "نجب" or w=="جب" then
if is_sudo(msg) then 
return   "حاضر تاج راسي انجبيت 😇 "
elseif is_owner(msg) then
return   "لخاطرك راح اسكت لان مدير وع راسي  😌"
elseif is_mod(msg) then
return   "فوك مامصعدك ادمن ؟؟ انته انجب 😏"
else
return   "انجب انته لاتندفر 😏"
end
elseif  data[tostring(msg.to.id)]['replay'] and data[tostring(msg.to.id)]['replay'][w] then
return  data[tostring(msg.to.id)]['replay'][w] 
elseif data['replay_all'] and data['replay_all'][w] then
return data['replay_all'][w] 
end
end 
else
return
end
---------------------------------------------

---------------------------------------------

end
return {
patterns = {
"^("..bot_name.." عفط)(.*)$", 
"^("..bot_name.." اتفل)(.*)$", 
"^("..bot_name.." رزله)(.*)$", 
"^("..bot_name.." بوس)(.*)$", 
"^(بوس)(.*)$", 
"^(تحب) (.*)$",
"^("..bot_name..") (.*)$",
"^(كله) (.*)$",
"^(كول) (.*)$",
"^(بوس) (.*)$", 
"^(مسح رد عام) (.*)$",
"^(مسح رد) (.*)$",
"(.*)" 
},
run = run,
}
end
