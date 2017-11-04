local function run(msg, matches)
	if not is_mod(msg) then return "◈￤ للاداريين فقط 🎖" end
if matches[1]=="زخرف" then

	if not matches[2] then
		return "اكتب الامر زخرف ثم ضع مسافه واكتب الجملة وستظهر لك نتائج الزخرفة بالانكليزي 🌑☔️ "	end
	if string.len(matches[2]) > 20 then
		return "متاح لك 20 حرف انكليزي فقط لايمكنك وضع حروف اكثر ❤️😐\n"
	end 
		if matches[2]:match("[\216-\219][\128-\191]") then
		return "◈￤ هذا الامر لزخرفه الانكلش فقط ."
		end
		
	local font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
	local font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
	local fonts = {
		"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
		"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
		"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",
		"მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,0,Գ,Ց,Դ,6,5,Վ,Յ,Զ,1,.,_",
		"Δ,Ɓ,C,D,Σ,F,G,H,I,J,Ƙ,L,Μ,∏,Θ,Ƥ,Ⴓ,Γ,Ѕ,Ƭ,Ʊ,Ʋ,Ш,Ж,Ψ,Z,λ,ϐ,ς,d,ε,ғ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
		"ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,0,9,8,7,6,5,4,3,2,1,.,_",
		"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
	}
---------------------------------------------------------------------------------------------------------------------
	local result = {}
	i=0
	for k=1,#fonts do
		i=i+1
		local tar_font = fonts[i]:split(",")
		local text = matches[2]
		local text = text:gsub("A",tar_font[1])
		local text = text:gsub("B",tar_font[2])
		local text = text:gsub("C",tar_font[3])
		local text = text:gsub("D",tar_font[4])
		local text = text:gsub("E",tar_font[5])
		local text = text:gsub("F",tar_font[6])
		local text = text:gsub("G",tar_font[7])
		local text = text:gsub("H",tar_font[8])
		local text = text:gsub("I",tar_font[9])
		local text = text:gsub("J",tar_font[10])
		local text = text:gsub("K",tar_font[11])
		local text = text:gsub("L",tar_font[12])
		local text = text:gsub("M",tar_font[13])
		local text = text:gsub("N",tar_font[14])
		local text = text:gsub("O",tar_font[15])
		local text = text:gsub("P",tar_font[16])
		local text = text:gsub("Q",tar_font[17])
		local text = text:gsub("R",tar_font[18])
		local text = text:gsub("S",tar_font[19])
		local text = text:gsub("T",tar_font[20])
		local text = text:gsub("U",tar_font[21])
		local text = text:gsub("V",tar_font[22])
		local text = text:gsub("W",tar_font[23])
		local text = text:gsub("X",tar_font[24])
		local text = text:gsub("Y",tar_font[25])
		local text = text:gsub("Z",tar_font[26])
		local text = text:gsub("a",tar_font[27])
		local text = text:gsub("b",tar_font[28])
		local text = text:gsub("c",tar_font[29])
		local text = text:gsub("d",tar_font[30])
		local text = text:gsub("e",tar_font[31])
		local text = text:gsub("f",tar_font[32])
		local text = text:gsub("g",tar_font[33])
		local text = text:gsub("h",tar_font[34])
		local text = text:gsub("i",tar_font[35])
		local text = text:gsub("j",tar_font[36])
		local text = text:gsub("k",tar_font[37])
		local text = text:gsub("l",tar_font[38])
		local text = text:gsub("m",tar_font[39])
		local text = text:gsub("n",tar_font[40])
		local text = text:gsub("o",tar_font[41])
		local text = text:gsub("p",tar_font[42])
		local text = text:gsub("q",tar_font[43])
		local text = text:gsub("r",tar_font[44])
		local text = text:gsub("s",tar_font[45])
		local text = text:gsub("t",tar_font[46])
		local text = text:gsub("u",tar_font[47])
		local text = text:gsub("v",tar_font[48])
		local text = text:gsub("w",tar_font[49])
		local text = text:gsub("x",tar_font[50])
		local text = text:gsub("y",tar_font[51])
		local text = text:gsub("z",tar_font[52])
		local text = text:gsub("0",tar_font[53])
		local text = text:gsub("9",tar_font[54])
		local text = text:gsub("8",tar_font[55])
		local text = text:gsub("7",tar_font[56])
		local text = text:gsub("6",tar_font[57])
		local text = text:gsub("5",tar_font[58])
		local text = text:gsub("4",tar_font[59])
		local text = text:gsub("3",tar_font[60])
		local text = text:gsub("2",tar_font[61])
		local text = text:gsub("1",tar_font[62])

		table.insert(result, text)
	end
		local result_text = "◈￤ زخرفة كلمة :  "..matches[2].."\n◈￤ تطبيق اكثر من "..tostring(#fonts).." نوع من الخطوط : \n🃏〰〰〰〰〰〰〰〰〰🃏\n\n"
	a=0
	for v=1,#result do
		a=a+1
		result_text = result_text..a.."- "..result[a].."\n\n"
	end
	return result_text.."🃏〰〰〰〰〰〰〰〰〰🃏\n"
	end


	if matches[1]=="زخرفه" then

	if not matches[2] then
		return "بعد هذا الأمر، ضع مسافه واكتب الكلمه المراد زخرفتها بالعربي فقط 🌑☔️"
	end
	if string.len(matches[2]) > 44 then
		return "◈￤ الحد الأقصى المسموح به 40 حرفاالأحرف الإنجليزية والأرقام"
	end
		if not matches[2]:match("[\216-\219][\128-\191]") then
		return "◈￤ هذا الامر لزخرفه العربي فقط ."
		end
	local font_base = "ء,ئ,ا,ب,ت,ث,ج,ح,خ,د,ذ,ر,ز,س,ش,ص,ض,ط,ظ,ع,غ,ق,ف,ك,ل,م,ن,ه,و,ي,0,9,8,7,6,5,4,3,2,1,.,_"
	local font_hash = "ي,و,ه,ن,م,ل,ك,ف,ق,غ,ع,ظ,ط,ض,ص,ش,س,ز,ر,ذ,د,خ,ح,ج,ث,ت,ب,ا,ئ,ء,0,1,2,3,4,5,6,7,8,9,.,_"
	local fonts = {
		"ء,ئ,ٳ,ٻً,تہ,ثہ,جہ,حہ,خہ,دٍ,ذً,ر,ڒٍ,سہ,شہ,صً,ض,طہ,ظً,عـ,غہ,قـً,فُہ,كُہ,لہ,مـْ,نٍ,ه,ﯝ,يہ,0ً,1,2ً,3ً,4ً,5ً,6ً,7َ,8ً,9ً,.,_",
		"ء,ئ,آ̲,ب̲,ت̲,ث̲,ج̲,ح̲,خ̲,د̲,ذ̲,ر̲,ز̲,س̲,ش̲,ص̲,ض,ط̲,ظً̲,ع̲,غ̲,ق̲,ف̲,ك̲,ل̲,م̲,ن̲,ہ̲,ۆ̲,ي̲,0̲,1̲,2̲,3̲,4̲,5̲,6̲,7̲,8̲,9̲,.,_",
		"ء,ئ,آ̯͡,ب̯͡,ت̯͡,ث̯͡,ج̯͡,ح̯͡,خ̯͡,د̯͡,ذ̯͡,ر̯͡,ز̯͡,س̯͡,ش̯͡,ص̯͡,ض,ط̯͡,ظ̯͡,ع̯͡,غ̯͡,ق̯͡,ف̯͡,ك̯͡,ل̯͡,م̯͡,ن̯͡,ہ̯͡,ۆ̯͡,ي̯͡,0̯͡,1̯͡,2̯͡,3̯͡,4̯͡,5̯͡,6̯͡,7̯͡,8̯͡,9̯͡,.,_",
		"ء,ئ,آ͠,ب͠,ت͠,ث͠,ج͠,ح͠,خ͠,د͠,ذ͠,ر,ز͠,س͠,ش͠,ص͠,ض,ط͠,ظ͠,ع͠,غ͠,ق͠,ف͠,گ͠,ل͠,م͠,ن͠,ه͠,و͠,ي͠,0͠,1͠,2͠,3͠,4͠,5͠,6͠,7͠,8͠,9͠,.,_",
		"ء,ئ,آ,ب,ت,ث,جٍ,حٍ,خـ,دِ,ڌ,رٍ,ز,س,شُ,ص,ض,طُ,ظً,عٍ,غ,ق,فَ,گ,لُ,م,ن,ہ,ۆ,يَ,₀,₁,₂,₃,₄,₅,₆,₇,₈,₉,.,_",	
		"ء,ئ,إآ,̜̌ب,تـ,,ثـ,جٍ,و,خ,ﮃ,ذ,رٍ,زً,سًٌُُ,شُ,ص,ض,طُ,ظً,۶,غ,ق,فَ,گ,لُ,مـ,ن,ه̷̸̐,ۈ,يَ,0,⇂,Շ,Ɛ,h,ʢ,9,L,8,6,.,_",
		"ء,ئ,آ,ب,ت,ث,جٍ,حٍ,خـ,دِ,ڌ,رٍ,ز,س,شُ,ص,ض,طُ,ظً,عٍ,غ,ق,فَ,گ,لُ,م,ن,ہ,ۆ,يَ,₀,₁,₂,₃,₄,₅,₆,₇,₈,₉,.,_",
		"ء,ئ,ٵ̷ ,ب̷,ت̷,ث̷,ج̷,ح̷,خ̷,د̷ِ,ذ̷,ر̷,ز̷,س̷,ش̷ُ,ص̷,ض,ط̷ُ,ظ̷ً,ع̷ٍ,غ̷,ق̷,ف̷َ,گ̷,ل̷,م̷,ن̷,ہ̷,ۆ̷,ي̷,0̷,1̷,2̷,3̷,4̷,5̷,6̷,7̷,8̷,9̷,.,_",
		"ء,ئ,آ,بُ,تْ,ثُ,ج,ح,ځ,ڊ,ڏ,ر,ڒٍ,ڛ,شُ,صً,ض,طُ,ظً,عٌ,غٍ,قٌ,فُ,ڪ,لُ,مْ,نْ,ﮩ,وُ,يُ,0,1,2,3,4,5,6,7,8,9,.,_",
		"ء,ئ,آ,بَ,ت,ث,جٍ,حٍ,خـ,دِ,ذَ,رٍ,زْ,س,شُ,ص,ض,طُ,ظً,عٍ,غ,قٌ,فُ,ڪ,لُِ,م,ن,هـ,وُ,ي,0̲̣̣̥,1̣̣̝̇̇,2̲̣̣̣̥,3̍̍̍̊,4̩̥,5̲̣̥,6̥̥̲̣̥,7̣̣̣̝̇̇̇,8̣̝̇,9̲̣̣̥,.,_",
		"ء,ئ,آ,ب,ت,ث,جٍ,حٍ,خـ,دِ,ڌ,رٍ,ز,س,شُ,ص,ض,طُ,ظً,عٍ,غ,ق,فَ,گ,لُ,م,ن,ہ,ۆ,يَ,₀,₁,₂,₃,₄,₅,₆,₇,₈,₉,.,_",
		"ء,ئ,ٵ̷ ,ب̷,ت̷,ث̷,ج̷,ح̷,خ̷,د̷ِ,ذ̷,ر̷,ز̷,س̷,ش̷ُ,ص̷,ض,ط̷ُ,ظ̷ً,ع̷ٍ,غ̷,ق̷,ف̷َ,گ̷,ل̷,م̷,ن̷,ہ̷,ۆ̷,ي̷,0̷,1̷,2̷,3̷,4̷,5̷,6̷,7̷,8̷,9̷,.,_",
		"ء,ئ,آ͠,ب͠,ت͠,ث͠,ج͠,ح͠,خ͠,د͠,ذ͠,ر,ز͠,س͠,ش͠,ص͠,ض,ط͠,ظ͠,ع͠,غ͠,ق͠,ف͠,گ͠,ل͠,م͠,ن͠,ه͠,و͠,ي͠,0͠,1͠,2͠,3͠,4͠,5͠,6͠,7͠,8͠,9͠,.,_",
		"ء,ئ,آ̯͡,ب̯͡,ت̯͡,ث̯͡,ج̯͡,ح̯͡,خ̯͡,د̯͡,ذ̯͡,ر̯͡,ز̯͡,س̯͡,ش̯͡,ص̯͡,ض,ط̯͡,ظ̯͡,ع̯͡,غ̯͡,ق̯͡,ف̯͡,ك̯͡,ل̯͡,م̯͡,ن̯͡,ہ̯͡,ۆ̯͡,ي̯͡,0̯͡,1̯͡,2̯͡,3̯͡,4̯͡,5̯͡,6̯͡,7̯͡,8̯͡,9̯͡,.,_",
	}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local result = {}
	i=0
	for k=1,#fonts do
		i=i+1
		local tar_font = fonts[i]:split(",")
		local text = matches[2]
		local text = text:gsub("ء",tar_font[1])
		local text = text:gsub("ئ",tar_font[2])
		local text = text:gsub("ا",tar_font[3])
		local text = text:gsub("ب",tar_font[4])
		local text = text:gsub("ت",tar_font[5])
		local text = text:gsub("ث",tar_font[6])
		local text = text:gsub("ج",tar_font[7])
		local text = text:gsub("ح",tar_font[8])
		local text = text:gsub("خ",tar_font[9])
		local text = text:gsub("د",tar_font[10])
		local text = text:gsub("ذ",tar_font[11])
		local text = text:gsub("ر",tar_font[12])
		local text = text:gsub("ز",tar_font[13])
		local text = text:gsub("س",tar_font[14])
		local text = text:gsub("ش",tar_font[15])
		local text = text:gsub("ص",tar_font[16])
		local text = text:gsub("ض",tar_font[17])
		local text = text:gsub("ط",tar_font[18])
		local text = text:gsub("ظ",tar_font[19])
		local text = text:gsub("ع",tar_font[20])
		local text = text:gsub("غ",tar_font[21])
		local text = text:gsub("ق",tar_font[22])
		local text = text:gsub("ف",tar_font[23])
		local text = text:gsub("ك",tar_font[24])
		local text = text:gsub("ل",tar_font[25])
		local text = text:gsub("م",tar_font[26])
		local text = text:gsub("ن",tar_font[27])
		local text = text:gsub("ه",tar_font[28])
		local text = text:gsub("و",tar_font[29])
		local text = text:gsub("ي",tar_font[30])
		local text = text:gsub("0",tar_font[31])
		local text = text:gsub("9",tar_font[32])
		local text = text:gsub("8",tar_font[33])
		local text = text:gsub("7",tar_font[34])
		local text = text:gsub("6",tar_font[35])
		local text = text:gsub("5",tar_font[36])
		local text = text:gsub("4",tar_font[37])
		local text = text:gsub("3",tar_font[38])
		local text = text:gsub("2",tar_font[39])
		local text = text:gsub("1",tar_font[40])

		table.insert(result, text)
	end
	local result_text = "◈￤ زخرفة : "..matches[2].."\n◈￤ تصميم "..tostring(#fonts).." خط :\n🃏〰〰〰〰〰〰〰〰〰🃏\n"
	a=0
	for v=1,#result do
		a=a+1
		result_text = result_text..a.."- "..result[a].."\n\n"
	end
	return result_text.."ـ〰〰〰〰〰〰〰〰〰\n"
end

	end

return {
	patterns = {
		"^(زخرف) (.*)",
		"^(زخرف)$",
		"^(زخرفه) (.*)",
		"^(زخرفه)$",
		},
	run = run
}
