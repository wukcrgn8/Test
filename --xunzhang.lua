module(..., package.seeall)

-------------------------------新的勋章系统-----------------------------------
--------------------------2014.11.27 code by zxs------------------------------

--勋章id
local YIJI_XZ = 80001;
local ERJI_XZ = 80002;
local SANJI_XZ = 80003;
local SIJI_XZ = 80004;
local WUJI_XZ = 80005;
local LIUJI_XZ = 80006;
local QIJI_XZ = 80007;
local BAJI_XZ = 80008;
local JIUJI_XZ = 80009;

--极品勋章id
local JP_SAN = 81003;
local JP_QI  = 81007;
local JP_BA  = 81008;
local JP_JIU = 81009;
--local JP_LIU = 81006;----六级勋章id未定，我瞎编的 六级极品屏蔽

--当前开放的最大等级勋章id
local XZ_MAX = JIUJI_XZ;
--当前开放的最大等级极品勋章id
local XZ_MAX = JP_JIU;
--正气令牌id
local ZQLP = 19029;

--浩气令牌id
local HQLP = 19140

--初级武魂id
local CJWH = 19069;



--合成一级勋章所需材料id 原来的是勋章碎片 ，现改为正气令牌
local XZSP = ZQLP;

--上述材料名称
local SP_NAME = "正气令牌";

--所需材料数量
local NEEDSP_NUM = 5;


--升级所需材料  武魂 和 正气令牌，顺序与下面的勋章信息对应
local wh_item ={
					{whclid = 0,whnum = 0,name = "初级武魂"},--1->2所需材料
					{whclid = CJWH,whnum = 1,name = "初级武魂"},--2->3所需材料
					{whclid = 0,whnum = 0,name = "初级武魂"},--3->4所需材料
					{whclid = 0,whnum = 0,name = "初级武魂"},--4->5所需材料
					{whclid = 0,whnum = 0,name = "初级武魂"},--5->6所需材料
					{whclid = HQLP,whnum = 100,name = "浩气令牌"}, --6->7所需材料
					{whclid = HQLP,whnum = 300,name = "浩气令牌"}, --7->8所需材料
					{whclid = HQLP,whnum = 800,name = "浩气令牌"}, --8->9所需材料					
				}
local zqlp_item={
					{lpid = ZQLP,lpnum = 10,name = "正气令牌"},--1->2所需材料
				    {lpid = ZQLP,lpnum = 50,name = "正气令牌"},--2->3所需材料
					{lpid = ZQLP,lpnum = 150,name = "正气令牌"},--3->4所需材料
					{lpid = ZQLP,lpnum = 350,name = "正气令牌"},--4->5所需材料
					{lpid = ZQLP,lpnum = 650,name = "正气令牌"}, --5->6所需材料
					{lpid = ZQLP,lpnum = 650,name = "正气令牌"}, --6->7所需材料
					{lpid = ZQLP,lpnum = 650,name = "正气令牌"}, --7->8所需材料
					{lpid = ZQLP,lpnum = 650,name = "正气令牌"}, --8->9所需材料					
				}
local cz_item1 = {
					{whclid = 10307,whnum = 5,name = "坐骑经验丹"}, --7级勋章重铸所需材料
					{whclid = 19066,whnum = 2,name = "转生丹"}, --8级勋章重铸所需材料
					{whclid = 10308,whnum = 2,name = "朱果"}, --9级勋章重铸所需材料
				}
local cz_item2 = {
					{lpid = 19057,lpnum = 3,name = "羽灵"}, --7级勋章重铸所需材料
					{lpid = 10846,lpnum = 2,name = "一级羽毛"}, --8级勋章重铸所需材料
					{lpid = 10307,lpnum = 2,name = "坐骑经验丹"}, --9级勋章重铸所需材料
				}
--勋章信息  name 名称,  typeid 存入数据库的id,xzlevel 勋章等级,  needlevel 所需等级 ,power 增加战斗力
local xzItem={
				{name = "一级试炼勋章", typeid = YIJI_XZ,  xzlevel = 1, needlevel = 44, power = 15257},
			  	{name = "二级裂空勋章", typeid = ERJI_XZ,  xzlevel = 2, needlevel = 49, power = 15257},
			  	{name = "三级锋芒勋章", typeid = SANJI_XZ, xzlevel = 3, needlevel = 54, power = 15257},
			  	{name = "四级正直勋章", typeid = SIJI_XZ,  xzlevel = 4, needlevel = 64, power = 15257},
			  	{name = "五级无畏勋章", typeid = WUJI_XZ,  xzlevel = 5, needlevel = 74, power = 15257},
			  	{name = "六级英勇勋章", typeid = LIUJI_XZ, xzlevel = 6, needlevel = 84, power = 15257},
			  	{name = "七级荣誉勋章", typeid = QIJI_XZ,  xzlevel = 7, needlevel = 100, power = 15257},
			  	{name = "八级敬畏勋章", typeid = BAJI_XZ,  xzlevel = 8, needlevel = 100, power = 15257},
			  	{name = "九级星芒勋章", typeid = JIUJI_XZ,  xzlevel = 9, needlevel = 100, power = 15257},			  	
			  }--六级没开所以这么写  战斗力和等级限制也是瞎掰的
local jpxz = {
			  {name = "三级锋芒勋章·极品", typeid = JP_SAN,  xzlevel = 3, needlevel = 54, power = 15257, jpgl = 0.1,czgl = 0},
			  {name = "七级荣誉勋章·极品", typeid = JP_QI,  xzlevel = 7, needlevel = 100, power = 15257, jpgl = 0.1,czgl = 0.1},
			  {name = "八级敬畏勋章·极品", typeid = JP_BA,  xzlevel = 8, needlevel = 100, power = 15257, jpgl = 0.1,czgl = 0.1},
			  {name = "九级星芒勋章·极品", typeid = JP_JIU,  xzlevel = 9, needlevel = 100, power = 15257, jpgl = 0.1,czgl = 0.1},
			}
--出现极品的等级
local JPLEVEL = {3,7,8,9};

--随机基数
local RANDOM_BOOT = 10000;
--物品所在位置
local BB    = 1;     --背包
local ZB_BB = 11;    --背包和身上已装备的
local ZB    = 10;    --身上已装备的
local CK    = 100;   --仓库



------------player:Window1(20,1,xxxxxx   20是勋章窗口id 第二个参数  0是勋章id和极品概率，1是勋章合成材料信息，2是合成勋章成功，3是失败
--合成一级勋章-------------------------------------------------------
function onTalk400(player)
	if player:num_item(XZSP,BB) >= NEEDSP_NUM then
		if not judge_bag(player,1) then
			player:Window1(20,3,"","","","xunzhang");
			return;
		end
		
		destory_xzcl_real(player, XZSP, NEEDSP_NUM);

		player:add_item(YIJI_XZ,BB);
		--player:use_item(YIJI_XZ);
		player:alert(10,4,"恭喜你合成"..xzItem[1].name);
		player:Window1(20,2,"2","","","xunzhang");--------第三个参数的意思是要客户端显示几级勋章合成界面
		onTalk301(player);
	else
		player:alert(10,4,"你没有足够的"..SP_NAME.."，无法合成"..xzItem[1].name.."！");
		player:Window1(20,3,"","","","xunzhang");
	end

end
-------------------------------------------------------------------------
----背包剩余格子判断
function judge_bag(player,num)
	if  player:num_bag_black() < num then
	    player:alert(10, 4, "背包空格不足"..num.."格,请先清理背包!");
		return false;
	end
	return true;
end
-------------------------------------------------------------------------

--给客户端各物品的id 及是否可合成极品信息 以xml的形式传输------------
---jpgl  极品概率
function onTalk100(player)
	player:push_item_desp(CJWH);
	player:push_item_desp(ZQLP);
	player:push_item_desp(YIJI_XZ);
	
	for i = 1 ,#jpxz do
		player:push_item_desp(jpxz[i].typeid);
	end

	xml = "<xzitem>";
	for i = 1, #xzItem do
		xml = xml.."<item typeid='"..xzItem[i].typeid.."' ";

		player:push_item_desp(xzItem[i].typeid);
		jpitem = get_jp_by_xzlevel(jpxz,xzItem[i].xzlevel);
		if jpitem ~= nil then
			xml = xml.."jpgl='"..jpitem.jpgl.."' ";
			xml = xml.."jpid='"..jpitem.typeid.."' ";
		end
		xml = xml.."/>";
	end

	xml = xml.."</xzitem>";
	player:Window1(20,0,xml,"","","xunzhang");
end
-------------------------------------------------------------------------
function onTalk300(player)
	xml = get_xzcl_xml_with_level(player,0);
	player:Window1(20,1,xml,"","","xunzhang");
end

function onTalk301(player)
	xml = get_xzcl_xml_with_level(player,1);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk302(player)
	xml = get_xzcl_xml_with_level(player,2);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk303(player)
	xml = get_xzcl_xml_with_level(player,3);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk304(player)
	xml = get_xzcl_xml_with_level(player,4);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk305(player)
	xml = get_xzcl_xml_with_level(player,5);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk306(player)
	xml = get_xzcl_xml_with_level(player,6);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk307(player)
	xml = get_xzcl_xml_with_level(player,7);
	player:Window1(20,1,xml,"","","xunzhang");
end
function onTalk308(player)
	xml = get_xzcl_xml_with_level(player,8);
	player:Window1(20,1,xml,"","","xunzhang");
end
--合成材料的信息组成xml
function get_xzcl_xml_with_level(player,level)
	local cl_1_id = 0;
	local cl_2_id = 0;
	local cl_3_id = 0;
	local cl_4_id = 0
	local cl_1_num = 1;
	local cl_2_num = 1;
	local cl_3_num = 1;
	local cl_4_num = 1
	-- 没有勋章时 合成材料是3个勋章碎片
	if level == 0 then
		cl_2_id = XZSP;
		cl_2_num = NEEDSP_NUM;
	end
	if level > 0 then
		cl_1_id = xzItem[level].typeid;
		if player:num_item(cl_1_id,ZB_BB) == 0 then
			jpitem = get_jp_by_xzlevel(jpxz,level)
			if jpitem ~= nil then
				jpid = jpitem.typeid
				if player:num_item(jpid) > 0 then
					cl_1_id = jpid;
				end
			end
		end
		cl_1_num = 1;
		cl_2_id = wh_item[level].whclid;
		cl_2_num = wh_item[level].whnum;
		cl_3_id = zqlp_item[level].lpid;
		cl_3_num = zqlp_item[level].lpnum;
	end
	xml ="";
	xml = xml.."<item ";

	if cl_1_id ~= 0 then
		xml = xml.."cl_1='"..cl_1_id.."' ";
		xml = xml.."cl_1_num='"..cl_1_num.."' ";
	end
	if cl_2_id ~= 0 then
		xml = xml.."cl_2='"..cl_2_id.."' ";
		xml = xml.."cl_2_num='"..cl_2_num.."' ";
    end
	if cl_3_id ~= 0 then
		xml = xml.."cl_3='"..cl_3_id.."' ";
		xml = xml.."cl_3_num='"..cl_3_num.."' ";
	end
	xml = xml.."/>";
	return xml;
end

--普通没有就取极品勋章
function normal_update(player,level)
	if not judge_bag(player,1) then    ---背包不足一格
		return false;
	end
	item = xzItem[level];
	jpitem = get_jp_by_xzlevel(jpxz,level);

	if player:num_item(item.typeid,ZB_BB) > 0 then
		return update_xz_item(player,item);
	elseif jpitem ~= nil and player:num_item(jpitem.typeid,ZB_BB) > 0 then
		return update_xz_item(player,jpitem);
	else
		player:alert(10,4,"你没有"..xzItem[level].name.."，无法合成"..xzItem[level+1].name.."！");
		return false;
	end
end
-------------------------------------------------------------------------


--一级升二级
function onTalk401(player)
	if normal_update(player,1) then
		player:Window1(20,2,"3","","","xunzhang");
		onTalk302(player);
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end
-------------------------------------------------------------------------
--二级升三级
function onTalk402(player)
	if normal_update(player,2) then
		player:Window1(20,2,"4","","","xunzhang");
		onTalk303(player);
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end
-------------------------------------------------------------------------
--三级升四级
function onTalk403(player)
	--print("3>>>>>>>>>>>4")
	if normal_update(player,3) then
		player:Window1(20,2,"5","","","xunzhang");
		onTalk304(player);
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end
-------------------------------------------------------------------------
--四级升五级
function onTalk404(player)
	if normal_update(player,4) then
		player:Window1(20,2,"6","","","xunzhang");
		--onTalk305(player);   
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end

--五级升六级
function onTalk405(player)
	if normal_update(player,5) then
		player:Window1(20,2,"7","","","xunzhang");
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end

--六级升七级
function onTalk406(player)
	if normal_update(player,6) then       -- 现在升7级，那下次应该是8级这个意思
		player:Window1(20,2,"8","","","xunzhang");
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end

--七级升八级
function onTalk407(player)
	if normal_update(player,7) then
		player:Window1(20,2,"9","","","xunzhang"); 
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end

--八级升九级
function onTalk408(player)
	if normal_update(player,8) then
		player:Window1(20,2,"9","","","xunzhang"); 
	else
		player:Window1(20,3,"","","","xunzhang");
	end
end

-------------------------------------------------------------------------

--勋章合成条件校验
function update_xz_item(player, item)
	if not check_xz(player,item.typeid) then
		return false;
	end
	local level = item.xzlevel;
	
	--if level == 0 then
		--return;
	--end

	if can_update(player,item) then
		return update_xz_with_iteminfo(player,item);
	else
		return false;
	end
end
-------------------------------------------------------------------------

--检查是否符合合成条件
function can_update(player,item)
	if not check_xz_level(player,item) then
		return false;
	elseif not check_zqlp(player,item) then
		return false;
	elseif not check_whcl(player,item) then
		return false;
	end
	return true;
end

-------------------------------------------------------------------------

-- 等级校验
function  check_xz_level(player,item)
	nextItem = xzItem[item.xzlevel+1];
	if player:get_level() < nextItem.needlevel and player:get_reborn_level() < 1  then
		player:alert(10,4,nextItem.needlevel.."级才能合成，请先努力升级吧！");
		return false;
	end
	return true;
end
-------------------------------------------------------------------------

-- 武魂材料校验
function  check_whcl(player,item)
	level = item.xzlevel;
	whinfo = wh_item[level];
	return check_cl(player,whinfo.whclid,whinfo.whnum,whinfo.name);
end
-------------------------------------------------------------------------

-- 正气令牌校验
function  check_zqlp(player,item)
	level = item.xzlevel;
	lpinfo = zqlp_item[level];
	return check_cl(player,lpinfo.lpid,lpinfo.lpnum,lpinfo.name);
end
-------------------------------------------------------------------------


---------背包物品个数校验------------------------------------------------
function check_cl(player, clid, clnum, clname)
	if player:num_item(clid,BB) < clnum  then
		player:alert(10,4,clname.."不足"..clnum.."个，无法合成");
		return false;
	end
	return true;
end
-------------------------------------------------------------------------

--排除没有勋章和勋章等级已到最高级的情况。
function check_xz(player,xzid)
	if xzid == 0 or  xzid == nil  then
		player:alert(10,4,"你身上没有勋章，不能升级！请少侠先用"..SP_NAME.."合成！");
		return false;
	end
	if xzid == XZ_MAX then
		player:alert(10,4,"您的勋章已经是最高级的了！");
		return false;
	end
	return true;
end
-------------------------------------------------------------------------


--如果下一级是出极品的等级，那么随机出极品勋章
function update_xz_with_iteminfo(player, item)
	level = item.xzlevel;
	jpitem = get_jp_by_xzlevel(jpxz,level+1);
	if jpitem ~= nil then
		local gl = jpitem.jpgl;
		local rNum = get_random_num(gl);

		local max = RANDOM_BOOT * gl;
		if rNum <= max then
			return update_xz_jp(player,item);
		else
			return update_xz_normal(player,item);
		end
	else
		return update_xz_normal(player,item);
	end

end
-------------------------------------------------------------------------

---数组中是否有某个元素
function hasitem(arry,item)
	for i = 1, #arry do
		if arry[i] == item then
			return true;
		end
	end
	return false;
end
-------------------------------------------------------------------------

--返回随机数
function get_random_num(gl)
	if gl > 1 then
		return RANDOM_BOOT;
	end
	return math.random(1,RANDOM_BOOT);
end
-------------------------------------------------------------------------

local destroy_xz = BB;
--普通升级勋章
function update_xz_normal(player,item)
	level = item.xzlevel;
	destroy_xzcl(player,item,level);

	newxz = xzItem[item.xzlevel+1].typeid;
	newname = xzItem[item.xzlevel+1].name;
	if (level+1) >6 then 
		player:add_item(newxz, 1, 1);  -- 超过6阶的为绑定
	else 
		player:add_item(newxz, 1);
	end 
	if destroy_xz == ZB then
		player:use_item(newxz);
	end
	if tonumber(player:get_param(6922)) < level+1 then
		player:set_param(6922,level+1);
	end
	--四级以上勋章合成成功，发公告
	if level+1 >= 4 then
		server.info(10,0,"恭喜勇士"..const.color_player_name(player:get_name()).."得到"..const.color_item_name(newname)..", 太炫了!![url=event:local_xunzhang_panel][00FF00]我也要合成[-][/url]");
		server.info(10000,0,"[44ddff]恭喜勇士"..const.color_player_name(player:get_name()).."得到"..const.color_item_name(newname)..", 太炫了!![-][url=event:local_xunzhang_panel][00FF00]我也要合成[-][/url]");
	end
	player:alert(10,4,"恭喜您成功合成"..newname);
	return true;
end
-------------------------------------------------------------------------
-------------升级极品勋章------------------------------------------------
function update_xz_jp(player,item)
	level = item.xzlevel;
	if not hasitem(JPLEVEL,level+1) then
		return;
	end

	destroy_xzcl(player,item,level);

	newitem = get_jp_by_xzlevel(jpxz,level+1);
	if newitem == nil then
		--print("没有相应等级的极品勋章");
		return;
	end
	newname = newitem.name;
	if (level+1) >6 then  
		player:add_item(newitem.typeid, 1, 1);-- 超过6阶的为绑定
	else 
		player:add_item(newitem.typeid, 1);
	end 
	if destroy_xz == ZB then
		player:use_item(newitem.typeid);
	end
	if tonumber(player:get_param(6922)) < level+1 then
		player:set_param(6922,level+1);
	end
	--极品勋章合成成功，发公告
	server.info(10,0,"恭喜勇士"..const.color_player_name(player:get_name()).."得到"..const.color_item_name(newname)..", 太炫了!![url=event:local_xunzhang_panel][00FF00]我也要合成[-][/url]");
	server.info(10000,0,"[44ddff]恭喜勇士"..const.color_player_name(player:get_name()).."得到"..const.color_item_name(newname)..", 太炫了!![-][url=event:local_xunzhang_panel][00FF00]我也要合成[-][/url]");

	player:alert(10,4,"恭喜您成功合成"..newname);
	return true;
end
-------------------------------------------------------------------------


------------------------销毁合成勋章材料---------------------------------
function destory_xzcl_real(player, destoryTypeId, numconsume)
	local bingnum = player:num_item(destoryTypeId,BB,1);
	if bingnum >= numconsume then
		player:remove_item(destoryTypeId, numconsume, BB, 110, 1);
		numconsume = 0;
	elseif bingnum > 0 and bingnum < numconsume then
		player:remove_item(destoryTypeId, bingnum, BB, 110, 1);
		numconsume = numconsume - bingnum;
	end
	
	if numconsume > 0 then
		player:remove_item(destoryTypeId,numconsume,BB);
	end
end

function destroy_xzcl(player,item,level)	
	destory_xzcl_real(player, zqlp_item[level].lpid, zqlp_item[level].lpnum);
	destory_xzcl_real(player, wh_item[level].whclid, wh_item[level].whnum);
	--优先处理身上装备了的勋章
	if player:num_item(item.typeid,ZB) > 0 then
		player:remove_item(item.typeid,1,ZB);
		destroy_xz = ZB;
	else
		player:remove_item(item.typeid,1,BB);
		destroy_xz = BB;
	end
end
-------------------------------------------------------------------------
--------------根据等级，返回勋章信息---------------------------------
function get_jp_by_xzlevel(jpxz,level)
	for i = 1 ,#jpxz do
		if jpxz[i].xzlevel == level then
			return jpxz[i];
		end
	end
	return nil;
end
-------------------------------------------------------------------------

------------------------------新勋章系统end------------------------------
----------------------------重铸勋章系统start----------------------------
function onTalk500(player)
	player:push_item_desp(CJWH);
	player:push_item_desp(ZQLP);
	player:push_item_desp(YIJI_XZ);
	
	for i = 1 ,#jpxz do
		player:push_item_desp(jpxz[i].typeid);
	end

	xml = "<xzitem>";
	for i = 7, #xzItem do
		xml = xml.."<item typeid='"..xzItem[i].typeid.."' ";

		player:push_item_desp(xzItem[i].typeid);
		jpitem = get_jp_by_xzlevel(jpxz,xzItem[i].xzlevel);
		if jpitem ~= nil then
			xml = xml.."jpgl='"..jpitem.jpgl.."' ";
			xml = xml.."jpid='"..jpitem.typeid.."' ";
		end
		xml = xml.."/>";
	end

	xml = xml.."</xzitem>";
	player:Window1(20,4,xml,"","","xunzhang");
end
----------七级勋章重铸---------
function onTalk507(player)
	if cz_normal_update(player,7) then
		player:Window1(20,2,"7","","","xunzhang");
		onTalk608(player);
	else
		onTalk607(player);
	end
end
----------十级勋章重铸---------
function onTalk508(player)
	if cz_normal_update(player,8) then
		player:Window1(20,2,"8","","","xunzhang");
		onTalk609(player);
	else
		onTalk608(player);
	end
end
----------九级勋章重铸---------
function onTalk509(player)
	if cz_normal_update(player,9) then
		player:Window1(20,2,"9","","","xunzhang");
	else
		onTalk609(player);
	end
end

function onTalk607(player)
	xml = get_czcl_xml_with_level(player,7);
	player:Window1(20,1,xml,"","","xunzhang");

end

function onTalk608(player)
	xml = get_czcl_xml_with_level(player,8);
	player:Window1(20,1,xml,"","","xunzhang");
end

function onTalk609(player)
	xml = get_czcl_xml_with_level(player,9);
	player:Window1(20,1,xml,"","","xunzhang");
end

--重铸材料的信息组成xml
function get_czcl_xml_with_level(player,level)
	local cl_1_id = 0;
	local cl_2_id = 0;
	local cl_3_id = 0;
	local cl_1_num = 1;
	local cl_2_num = 1;
	local cl_3_num = 1;
	-- 没有勋章时 合成材料是3个勋章碎片
	if level == 0 then
		cl_2_id = XZSP;
		cl_2_num = NEEDSP_NUM;
	end
	if level > 0 then
		cl_1_id = xzItem[level].typeid;
		if player:num_item(cl_1_id,ZB_BB) == 0 then
			--jpitem = get_jp_by_xzlevel(jpxz,level)
			if jpitem ~= nil then
				jpid = jpitem.typeid
				if player:num_item(jpid) > 0 then
					cl_1_id = jpid;
				end
			end
		end
		cl_1_num = 1;
		cl_2_id = cz_item1[level-6].whclid;
		cl_2_num = cz_item1[level-6].whnum;
		cl_3_id = cz_item2[level-6].lpid;
		cl_3_num = cz_item2[level-6].lpnum;
	end
	xml ="";
	xml = xml.."<item ";

	if cl_1_id ~= 0 then
		xml = xml.."cl_1='"..cl_1_id.."' ";
		xml = xml.."cl_1_num='"..cl_1_num.."' ";
	end
	if cl_2_id ~= 0 then
		xml = xml.."cl_2='"..cl_2_id.."' ";
		xml = xml.."cl_2_num='"..cl_2_num.."' ";
    end
	if cl_3_id ~= 0 then
		xml = xml.."cl_3='"..cl_3_id.."' ";
		xml = xml.."cl_3_num='"..cl_3_num.."' ";
	end
	xml = xml.."/>";
	return xml;
end

--普通没有就取极品勋章
function cz_normal_update(player,level)

	if not judge_bag(player,1) then    ---背包不足一格
		return false;
	end

	item = xzItem[level];

	if player:num_item(item.typeid,ZB_BB) > 0 then
		return update_cz_item(player,item);
	else
		player:alert(10,4,"你没有"..xzItem[level].name.."，无法重铸"..jpxz[level-5].name.."！");
		return false;
	end
end

--勋章合成条件校验
function update_cz_item(player, item)
	if not check_cz(player,item.typeid) then --
		return false;
	end
	local level = item.xzlevel;

	if cz_can_update(player,item) then--
		return update_cz_with_iteminfo(player,item);
	else
		return false;
	end
end

--排除没有勋章和勋章等级已到最高级的情况。
function check_cz(player,xzid)
	if xzid == 0 or  xzid == nil  then
		player:alert(10,4,"你身上没有勋章，不能升级！请少侠先用"..SP_NAME.."合成！");
		return false;
	end
	if xzid == CZ_MAX then
		player:alert(10,4,"您的勋章已经是最高级的了！");
		return false;
	end
	return true;
end

--检查是否符合合成条件
function cz_can_update(player,item)
	if not check_cz_level(player,item) then
		return false;
	elseif not check_cz_zqlp(player,item) then
		return false;
	elseif not check_cz_whcl(player,item) then
		return false;
	end
	return true;
end

-- 等级校验
function  check_cz_level(player,item)
	nextItem = xzItem[item.xzlevel];
	if player:get_level() < nextItem.needlevel and player:get_reborn_level() < 1  then
		player:alert(10,4,nextItem.needlevel.."级才能重铸，请先努力升级吧！");
		return false;
	end
	return true;
end
-------------------------------------------------------------------------

-- 武魂材料校验
function  check_cz_whcl(player,item)
	level = item.xzlevel;
	whinfo = cz_item1[level-6];
	return check_cz_cl(player,whinfo.whclid,whinfo.whnum,whinfo.name);
end
-------------------------------------------------------------------------

-- 正气令牌校验
function  check_cz_zqlp(player,item)
	level = item.xzlevel;
	lpinfo = cz_item2[level-6];
	return check_cz_cl(player,lpinfo.lpid,lpinfo.lpnum,lpinfo.name);
end
-------------------------------------------------------------------------


---------背包物品个数校验------------------------------------------------
function check_cz_cl(player, clid, clnum, clname)
	if player:num_item(clid,BB) < clnum  then
		player:alert(10,4,clname.."不足"..clnum.."个，无法重铸");
		return false;
	end
	return true;
end
-------------------------------------------------------------------------
--如果下一级是出极品的等级，那么随机出极品勋章
function update_cz_with_iteminfo(player, item)
	level = item.xzlevel;
	jpitem = get_jp_by_xzlevel(jpxz,level-5);
	if jpitem ~= nil then
		local gl = jpitem.jpgl;
		local rNum = get_random_num(gl);

		local max = RANDOM_BOOT * gl;
		if rNum <= max then
			return update_cz_jp(player,item);
		else
			player:alert(10,4,"运气不佳!重铸"..jpitem.name.."失败！");
		end
	else
		player:alert(10,4,"重铸系统出现异常");
	end

end
-------------升级极品勋章------------------------------------------------
function update_cz_jp(player,item)
	level = item.xzlevel;
	if not hasitem(JPLEVEL,level) then
		return;
	end

	destroy_xzcl(player,item,level); -- 销毁材料

	newitem = get_jp_by_xzlevel(jpxz,level-5);
	if newitem == nil then
		--print("没有相应等级的极品勋章");
		return;
	end
	newname = newitem.name;
	if (level+1) >6 then  
		player:add_item(newitem.typeid, 1, 1);-- 超过6阶的为绑定
	else 
		player:add_item(newitem.typeid, 1);
	end 
	if destroy_xz == ZB then
		player:use_item(newitem.typeid);
	end

	--极品勋章合成成功，发公告
	server.info(10,0,"恭喜勇士"..const.color_player_name(player:get_name()).."得到"..const.color_item_name(newname)..", 太炫了!![url=event:local_xunzhang_panel][00FF00]我也要合成[-][/url]");
	server.info(10000,0,"[44ddff]恭喜勇士"..const.color_player_name(player:get_name()).."得到"..const.color_item_name(newname)..", 太炫了!![-][url=event:local_xunzhang_panel][00FF00]我也要合成[-][/url]");

	player:alert(10,4,"恭喜您成功合成"..newname);
	return true;
end