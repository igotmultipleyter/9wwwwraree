

const DEFAULT = {
  Settings:{Notifications:true,ActiveGun:true,SpectatorHide:false,ConfigSyncEnabled:true,ConfigSyncURL:"",ConfigSyncInterval:3},
  SilentAim:{Enabled:true,ForceHit:true,AutoPrediction:false,AxisMode:"XY",Value:0.147,ValueX:0.15429184,ValueY:0.14163852,ValueZ:0.15290471,CloseClamp:true,CloseDist:28,CloseScale:0.42,Future:true,FutureAmount:0.12,FutureMin:35,ClampY:true,AntiCurve:false,MaxAngle:120,BasePart:"UpperTorso",PartPriority:"UpperTorso,HumanoidRootPart,Head,LowerTorso",Toggle:"P",Lock:"T",Fov:220,Knocked:true,WallCheck:false,AntiGround:true},
  AimAssist:{Enabled:true,LockMode:"Camera",Deadzone:2,FrameSkip:1,Sticky:true,SmoothOn:true,Smoothness:0.028,Style:"Sine",Dir:"Out",AutoPrediction:false,AxisMode:"XY",ValueX:0.15638291,ValueY:0.14384726,ValueZ:0.15192847,CamAxis:"All",Toggle:"M",Lock:"C",Fov:200},
  TriggerBot:{Enabled:true,Mode:"Silent",Pred:0.14638291,Scale:1.2,FovOn:true,Sticky:true,OnlyTool:true,Delay:0.08,DoubleTapDB:true,DBGap:0.04,DBPause:0.28,Toggle:"J"},
  ESP:{Enabled:true,Key:"LeftAlt",Boxes:true,Names:true},
  AntiMod:{Enabled:true,Action:"Notify",GroupIds:"996191638"},
  Misc:{AntiAfk:true,AntiFling:true,NoJump:false,NoSlow:false,NoRecoil:false,AutoReset:false,ResetHP:15},
  AutoBuy:{Enabled:true,KeyOnly:true,Key:"V",Distance:5000,Cooldown:0.08,ArmorValue:50,Armor:true,USP:true,Shotgun:false},
  Panic:{Enabled:true,Key:"X"},
  AntiFuture:{Enabled:false},
  Macro:{Enabled:false,Key:"B",Speed:28},
  Skin:{SkinOn:false,Skin:"galaxy",BulletOn:false,Bullet:"red",SkyOn:false,Sky:"blue"}
};
let state = JSON.parse(localStorage.getItem("ninewr_ui_v2")||"null") || JSON.parse(JSON.stringify(DEFAULT));
const SECTIONS = [["Settings","Settings"],["SilentAim","Silent Aim"],["AimAssist","Aim Assist"],["TriggerBot","Trigger Bot"],["ESP","ESP"],["AntiMod","Anti Mod"],["Misc","Miscellaneous"],["AutoBuy","Auto Buy"],["Panic","Panic"],["AntiFuture","Anti Future"],["Macro","Macro"],["Skin","Skin / Colors"]];
function toast(m){const t=document.getElementById("toast");t.textContent=m;t.classList.add("show");setTimeout(()=>t.classList.remove("show"),2200)}
function persist(){localStorage.setItem("ninewr_ui_v2",JSON.stringify(state))}
function get(p){return p.split(".").reduce((o,k)=>o==null?undefined:o[k],state)}
function set(p,v){const a=p.split(".");let o=state;for(let i=0;i<a.length-1;i++){if(!o[a[i]]||typeof o[a[i]]!=="object")o[a[i]]={};o=o[a[i]]}o[a[a.length-1]]=v;persist()}
function field(sec,path,label,type,opts){
  const w=document.createElement("div");w.className="field"+(type==="bool"?" row":"");
  const l=document.createElement("label");l.textContent=label;w.appendChild(l);
  if(type==="bool"){const sw=document.createElement("label");sw.className="switch";const i=document.createElement("input");i.type="checkbox";i.checked=!!get(path);i.onchange=()=>set(path,i.checked);const s=document.createElement("span");s.className="slider";sw.append(i,s);w.appendChild(sw)}
  else if(type==="select"){const s=document.createElement("select");(opts||[]).forEach(o=>{const op=document.createElement("option");op.value=o;op.textContent=o;if(get(path)===o)op.selected=true;s.appendChild(op)});s.onchange=()=>set(path,s.value);w.appendChild(s)}
  else{const i=document.createElement("input");i.type=type==="num"?"number":"text";if(type==="num")i.step="any";i.value=get(path)??"";i.onchange=()=>set(path,type==="num"?parseFloat(i.value):i.value);w.appendChild(i)}
  sec.appendChild(w);
}
function render(){
  const nav=document.getElementById("nav"), root=document.getElementById("sections");
  nav.innerHTML="";root.innerHTML="";
  SECTIONS.forEach(([id,title],idx)=>{
    const b=document.createElement("button");b.textContent=title;if(!idx)b.classList.add("active");
    b.onclick=()=>{document.querySelectorAll("nav button").forEach(x=>x.classList.remove("active"));document.querySelectorAll(".section").forEach(x=>x.classList.remove("active"));b.classList.add("active");document.getElementById("s-"+id).classList.add("active")};
    nav.appendChild(b);
    const sec=document.createElement("div");sec.className="section"+(idx?"":" active");sec.id="s-"+id;
    sec.innerHTML='<h2 style="margin:0 0 12px;font-size:18px">'+title+'</h2>';
    const g=document.createElement("div");g.className="grid";sec.appendChild(g);
    const add=(p,l,t,o)=>field(g,p,l,t,o);
    if(id==="Settings"){add("Settings.Notifications","Notifications","bool");add("Settings.ActiveGun","Active Gun","bool");add("Settings.SpectatorHide","Spectator Hide","bool");add("Settings.ConfigSyncEnabled","Config Sync Enabled","bool");add("Settings.ConfigSyncURL","Config Sync URL (raw JSON)","text");add("Settings.ConfigSyncInterval","Poll Interval (sec)","num")}
    if(id==="SilentAim"){add("SilentAim.Enabled","Enabled","bool");add("SilentAim.ForceHit","Force Hit","bool");add("SilentAim.AutoPrediction","Auto Prediction","bool");add("SilentAim.AxisMode","Axis Mode","select",["Manual","XY","XYZ"]);add("SilentAim.Value","Manual Value","num");add("SilentAim.ValueX","Value X","num");add("SilentAim.ValueY","Value Y","num");add("SilentAim.ValueZ","Value Z","num");add("SilentAim.CloseClamp","Close Range Clamp","bool");add("SilentAim.CloseDist","Clamp Distance","num");add("SilentAim.CloseScale","Clamp Scale","num");add("SilentAim.Future","Future","bool");add("SilentAim.FutureAmount","Future Amount","num");add("SilentAim.FutureMin","Future Min Dist","num");add("SilentAim.ClampY","Clamp Y","bool");add("SilentAim.AntiCurve","Anti Curve","bool");add("SilentAim.MaxAngle","Max Angle","num");add("SilentAim.BasePart","Base Part","text");add("SilentAim.PartPriority","Part Priority","text");add("SilentAim.Toggle","Toggle Key","text");add("SilentAim.Lock","Lock Key","text");add("SilentAim.Fov","FOV Size","num");add("SilentAim.Knocked","Check Knocked","bool");add("SilentAim.WallCheck","Wall Check","bool");add("SilentAim.AntiGround","Anti Ground","bool")}
    if(id==="AimAssist"){add("AimAssist.Enabled","Enabled","bool");add("AimAssist.LockMode","Lock Mode","select",["Camera","Mouse"]);add("AimAssist.Deadzone","Deadzone","num");add("AimAssist.FrameSkip","Frame Skip","num");add("AimAssist.Sticky","Sticky","bool");add("AimAssist.SmoothOn","Smooth On","bool");add("AimAssist.Smoothness","Smoothness","num");add("AimAssist.Style","Style","select",["Sine","Quad","Cubic","Linear","Back"]);add("AimAssist.Dir","Direction","select",["In","Out","InOut"]);add("AimAssist.AutoPrediction","Auto Prediction","bool");add("AimAssist.AxisMode","Axis Mode","select",["Manual","XY","XYZ"]);add("AimAssist.ValueX","Value X","num");add("AimAssist.ValueY","Value Y","num");add("AimAssist.ValueZ","Value Z","num");add("AimAssist.CamAxis","Cam Axis","select",["All","Center","Up"]);add("AimAssist.Toggle","Toggle Key","text");add("AimAssist.Lock","Lock Key","text");add("AimAssist.Fov","FOV Size","num")}
    if(id==="TriggerBot"){add("TriggerBot.Enabled","Enabled","bool");add("TriggerBot.Mode","Mode","select",["Hitbox","FOV","Silent"]);add("TriggerBot.Pred","Prediction","num");add("TriggerBot.Scale","Scale","num");add("TriggerBot.FovOn","FOV On","bool");add("TriggerBot.Sticky","Sticky FOV","bool");add("TriggerBot.OnlyTool","Only With Tool","bool");add("TriggerBot.Delay","Delay","num");add("TriggerBot.DoubleTapDB","Double Tap DB","bool");add("TriggerBot.DBGap","DB Gap","num");add("TriggerBot.DBPause","DB Pause","num");add("TriggerBot.Toggle","Toggle Key","text")}
    if(id==="ESP"){add("ESP.Enabled","Enabled","bool");add("ESP.Key","Hold Key","text");add("ESP.Boxes","Boxes","bool");add("ESP.Names","Names","bool")}
    if(id==="AntiMod"){add("AntiMod.Enabled","Enabled","bool");add("AntiMod.Action","Action","select",["Notify","Kick","Crash","Server Hop"]);add("AntiMod.GroupIds","Group IDs","text")}
    if(id==="Misc"){add("Misc.AntiAfk","Anti AFK","bool");add("Misc.AntiFling","Anti Fling","bool");add("Misc.NoJump","No Jump Cooldown","bool");add("Misc.NoSlow","No Slowdown","bool");add("Misc.NoRecoil","No Recoil","bool");add("Misc.AutoReset","Auto Reset","bool");add("Misc.ResetHP","Reset Health","num")}
    if(id==="AutoBuy"){add("AutoBuy.Enabled","Enabled","bool");add("AutoBuy.KeyOnly","Only On Keybind","bool");add("AutoBuy.Key","Keybind","text");add("AutoBuy.Distance","Distance","num");add("AutoBuy.Cooldown","Cooldown","num");add("AutoBuy.ArmorValue","Armor Below %","num");add("AutoBuy.Armor","Buy Armor","bool");add("AutoBuy.USP","Buy USP","bool");add("AutoBuy.Shotgun","Buy Shotgun","bool")}
    if(id==="Panic"){add("Panic.Enabled","Enabled","bool");add("Panic.Key","Keybind","text")}
    if(id==="AntiFuture"){add("AntiFuture.Enabled","Enabled","bool")}
    if(id==="Macro"){add("Macro.Enabled","Enabled","bool");add("Macro.Key","Keybind","text");add("Macro.Speed","Speed","num")}
    if(id==="Skin"){add("Skin.SkinOn","Skin Enabled","bool");add("Skin.Skin","Skin Name","text");add("Skin.BulletOn","Bullet Color On","bool");add("Skin.Bullet","Bullet Color","text");add("Skin.SkyOn","Sky Color On","bool");add("Skin.Sky","Sky Color","text")}
    root.appendChild(sec);
  });
}
function toEngine(){
  const s=state; const pri=(s.SilentAim.PartPriority||"").split(",").map(x=>x.trim()).filter(Boolean);
  return {
    Settings:{Notifications:s.Settings.Notifications,"Performance Mode":{ActiveGun:s.Settings.ActiveGun},"Spectator Hide":{Enabled:s.Settings.SpectatorHide},"Config Sync":{Enabled:s.Settings.ConfigSyncEnabled,URL:s.Settings.ConfigSyncURL,Interval:s.Settings.ConfigSyncInterval,"Notify On Apply":true}},
    "Silent Aim":{Enabled:s.SilentAim.Enabled,HitChance:[false,100],"Force Hit":s.SilentAim.ForceHit,Scale:1,"Override Y Axis":"half",Recast:false,"Max Distance":0,Prediction:{Enabled:true,"Auto Prediction":s.SilentAim.AutoPrediction,"Axis Mode":s.SilentAim.AxisMode,Value:s.SilentAim.Value,ValueX:s.SilentAim.ValueX,ValueY:s.SilentAim.ValueY,ValueZ:s.SilentAim.ValueZ,"Bullet Speed":1200,"Close Range Clamp":{Enabled:s.SilentAim.CloseClamp,Distance:s.SilentAim.CloseDist,Scale:s.SilentAim.CloseScale}},Future:{Enabled:s.SilentAim.Future,Amount:s.SilentAim.FutureAmount,"Max Studs":6,"Min Distance":s.SilentAim.FutureMin},"Clamp Y Axis":{Enabled:s.SilentAim.ClampY,Dynamic:true,Amount:0.45},"Anti Curve":{Enabled:s.SilentAim.AntiCurve,"Max Angle":s.SilentAim.MaxAngle},Target:{BasePart:s.SilentAim.BasePart,"Part Priority":pri,"Closest Point":false,"Closest Point Scale":1,"Closest Point Mode":"Basic","DB Part":"UpperTorso","USP FOV Scale":0.65},Toggle:{Enabled:true,Input:s.SilentAim.Toggle},"Keybind Mode":{Enabled:true,Input:s.SilentAim.Lock},Fov:{"2d-Circle":{Visible:false,SizeX:s.SilentAim.Fov,SizeY:s.SilentAim.Fov,Size:s.SilentAim.Fov,Thickness:1,"Outline Color":[37,150,190]},"3d":{Enabled:false,X:140,Y:140,Z:140}},Checks:{Knocked:s.SilentAim.Knocked,ForceField:true,Grabbed:true,"Anti Floor":true,"Disable While Typing":true,"Wall Check":s.SilentAim.WallCheck,Friend:false,"Anti Ground Shots":s.SilentAim.AntiGround}},
    "Aim Assist":{Enabled:s.AimAssist.Enabled,Scale:1,"Lock Mode":s.AimAssist.LockMode,"Max Distance":0,Deadzone:s.AimAssist.Deadzone,"Frame Skip":s.AimAssist.FrameSkip,"Sticky Mode":{Enabled:s.AimAssist.Sticky},Smoothness:[s.AimAssist.SmoothOn,s.AimAssist.Smoothness],"Smoothness Style":s.AimAssist.Style,"Smoothness Direction":s.AimAssist.Dir,Prediction:{Enabled:true,"Auto Prediction":s.AimAssist.AutoPrediction,"Axis Mode":s.AimAssist.AxisMode,Value:s.AimAssist.ValueX,ValueX:s.AimAssist.ValueX,ValueY:s.AimAssist.ValueY,ValueZ:s.AimAssist.ValueZ,"Bullet Speed":1200,"Cam Axis":s.AimAssist.CamAxis},"Clamp Y Axis":{Enabled:true,Dynamic:true,Amount:0.45},Target:{BasePart:"UpperTorso"},Toggle:{Enabled:true,Input:s.AimAssist.Toggle},"Keybind Mode":{Enabled:true,Input:s.AimAssist.Lock},Fov:{"2d-Circle":{Visible:false,SizeX:s.AimAssist.Fov,SizeY:s.AimAssist.Fov,Size:s.AimAssist.Fov,Thickness:1,"Outline Color":[37,150,190]},"3d":{Enabled:false,X:130,Y:130,Z:130}},Checks:{Knocked:true,ForceField:true,Grabbed:true,"Anti Floor":true,"Disable While Typing":true,"Wall Check":false,Friend:false,"Anti Ground Shots":true}},
    TriggerBot:{Enabled:s.TriggerBot.Enabled,"Max Distance":0,Mode:s.TriggerBot.Mode,Prediction:{Mode:"Single",Value:s.TriggerBot.Pred,ValueX:s.TriggerBot.Pred,ValueY:s.TriggerBot.Pred,ValueZ:s.TriggerBot.Pred},Scale:s.TriggerBot.Scale,Fov:{Enabled:s.TriggerBot.FovOn,"Sticky To Target":s.TriggerBot.Sticky,"Only With Tool":s.TriggerBot.OnlyTool,X:110,Y:110,Z:130},Delay:{Enabled:true,Normal:s.TriggerBot.Delay,Randomized:[true,0.06,0.10],"Per Gun":{db:0.11,rev:0.09,usp:0.07,tactical:0.1,shotgun:0.12}},"Double Tap DB":{Enabled:s.TriggerBot.DoubleTapDB,Gap:s.TriggerBot.DBGap,Pause:s.TriggerBot.DBPause},Toggle:{Enabled:true,Input:s.TriggerBot.Toggle},Checks:{Tools:true,Knife:true,Katana:true,Melee:false,Knocked:true,ForceField:true,"Anti Floor":true,"Disable While Typing":true,"Wall Check":false,Grabbed:false,Friend:false,"Anti Ground":true}},
    "Panic Mode":{Enabled:s.Panic.Enabled,Keybind:s.Panic.Key},"Anti Future":{Enabled:s.AntiFuture.Enabled},ESP:{Enabled:s.ESP.Enabled,Keybind:s.ESP.Key,Boxes:s.ESP.Boxes,Names:s.ESP.Names},
    "Anti Mod":{Enabled:s.AntiMod.Enabled,Action:s.AntiMod.Action,GroupIds:(s.AntiMod.GroupIds||"").split(",").map(x=>parseInt(x.trim(),10)).filter(n=>!isNaN(n)),Sound:"rbxassetid://330595293"},
    Miscellaneous:{"Anti Afk":s.Misc.AntiAfk,"Anti Fling":s.Misc.AntiFling,"No Jump Cooldown":s.Misc.NoJump,"No Slowdown":s.Misc.NoSlow,"No Recoil":s.Misc.NoRecoil,"Auto Reset":{Enabled:s.Misc.AutoReset,Health:s.Misc.ResetHP}},
    "Auto Buy":{Enabled:s.AutoBuy.Enabled,BuyDistance:s.AutoBuy.Distance,Cooldown:s.AutoBuy.Cooldown,WorkOnlyOnKeybind:s.AutoBuy.KeyOnly,Keybind:s.AutoBuy.Key,ArmorValue:s.AutoBuy.ArmorValue,"Buy Armor":s.AutoBuy.Armor,"Buy USP":s.AutoBuy.USP,"Buy Shotgun":s.AutoBuy.Shotgun},
    "Macro Abuse":{Enabled:s.Macro.Enabled,Keybind:s.Macro.Key,Speed:s.Macro.Speed},"Skin Changer":{Enabled:s.Skin.SkinOn,Skin:s.Skin.Skin},"Bullet Color":{Enabled:s.Skin.BulletOn,Color:s.Skin.Bullet},"Sky Color":{Enabled:s.Skin.SkyOn,Color:s.Skin.Sky},
    _meta:{version:Date.now(),source:"9wrwares-config-ui"}
  };
}
function download(){const blob=new Blob([JSON.stringify(toEngine(),null,2)],{type:"application/json"});const a=document.createElement("a");a.href=URL.createObjectURL(blob);a.download="9wrwares_config.json";a.click();URL.revokeObjectURL(a.href)}
document.getElementById("apply").onclick=()=>{persist();download();toast(state.Settings.ConfigSyncURL?"Upload JSON to your Config Sync URL":"Set Config Sync URL, then host this JSON there")};
document.getElementById("copy").onclick=()=>{navigator.clipboard.writeText(JSON.stringify(toEngine(),null,2)).then(()=>toast("JSON copied"))};
document.getElementById("reset").onclick=()=>{state=JSON.parse(JSON.stringify(DEFAULT));persist();render();toast("Reset")};
render();
