-- ffi setup
local ffi = require("ffi")
local C = ffi.C
ffi.cdef [[
	typedef uint64_t UniverseID;

	typedef struct {
		float x;
		float y;
		float z;
	} Coord3D;
	typedef struct {
		const char* id;
		const char* name;
		int32_t state;
		const char* requiredversion;
		const char* installedversion;
	} InvalidPatchInfo;
	typedef struct {
		const char* classid;
		Coord3D size;
		bool inverted;
	} RegionBoundary;
	typedef struct {
		const char* id;
		uint32_t numfields;
		uint32_t numboundaries;
		uint32_t numresources;
		Coord3D size;
		float density;
		float speed;
		float rotationSpeed;
		float defaultNoiseScale;
		float defaultMinNoiseValue;
		float defaultMaxNoiseValue;
	} RegionDefinition;
	typedef struct {
		const char* fieldtype;
		const char* groupref;
	} RegionField;
	typedef struct {
		const char* wareid;
		const char* yield;
	} RegionResource;
	typedef struct {
		Coord3D offset;
		Coord3D tangent;
		float weight;
		float inlength;
		float outlength;
	} SplineData;
	typedef struct {
		const char* name;
		const char* id;
		const char* source;
		bool deleteable;
	} UIConstructionPlan;
	typedef struct {
		float x;
		float y;
		float z;
		float yaw;
		float pitch;
		float roll;
	} UIPosRot;

	void AddCluster(const char* macroname, UIPosRot offset);
	void AddGateConnection(UniverseID gateid, UniverseID othergateid);
	UniverseID AddHoloMap(const char* texturename, float x0, float x1, float y0, float y1, float aspectx, float aspecty);
	void AddSector(UniverseID clusterid, const char* macroname, UIPosRot offset);
	void ClearSelectedMapComponents(UniverseID holomapid);
	uint64_t ConvertStringTo64Bit(const char* idstring);
	void ExportMap(const char* mapname, const char* extensionid, bool personal);
	bool FindMacro(const char* macroname);
	uint32_t GetAllFactions(const char** result, uint32_t resultlen, bool includehidden);
	uint32_t GetCatalogTemplates(const char** result, uint32_t resultlen, const char* classid);
	int32_t GetCheckpointSequence(UniverseID checkpointid);
	const char* GetClusterBackground(UniverseID clusterid);
	const char* GetComponentName(UniverseID componentid);
	uint32_t GetConstructionPlanInvalidPatches(InvalidPatchInfo* result, uint32_t resultlen, const char* constructionplanid);
	uint32_t GetConstructionPlans(UIConstructionPlan* result, uint32_t resultlen);
	UniverseID GetContextByClass(UniverseID componentid, const char* classname, bool includeself);
	uint32_t GetHighwaySplinePoints(SplineData* result, uint32_t resultlen, UniverseID highwayid);
	const char* GetMacroClass(const char* macroname);
	uint32_t GetMacrosStartingWith(const char** result, uint32_t resultlen, const char* partialmacroname);
	uint32_t GetMapEditorObjectList(UniverseID* result, uint32_t resultlen);
	uint32_t GetNumAllFactions(bool includehidden);
	uint32_t GetNumCatalogTemplates(const char* classid);
	uint32_t GetNumConstructionPlans(void);
	uint32_t GetNumHighwaySplinePoints(UniverseID highwayid);
	uint32_t GetNumMacrosStartingWith(const char* partialmacroname);
	uint32_t GetNumMapEditorObjectList(void);
	uint32_t GetNumRegionDefinitions(void);
	uint32_t GetNumSectors(UniverseID clusterid);
	UIPosRot GetObjectPositionInSector(UniverseID objectid);
	UniverseID GetPlayerGalaxyID(void);
	UniverseID GetPlayerID(void);
	UIPosRot GetPositionalOffset(UniverseID positionalid, UniverseID spaceid);
	uint32_t GetRegionBoundaries(RegionBoundary* result, uint32_t resultlen, const char* regiondefinition);
	const char* GetRegionDefinition(UniverseID regionid);
	uint32_t GetRegionDefinitions(RegionDefinition* result, uint32_t resultlen);
	uint32_t GetRegionFields(RegionField* result, uint32_t resultlen, const char* regiondefinition);
	uint32_t GetRegionResources(RegionResource* result, uint32_t resultlen, const char* regiondefinition);
	bool IsConstructionPlanValid(const char* constructionplanid, uint32_t* numinvalidpatches);
	bool IsMasterVersion(void);
	bool IsPlayerContext(UniverseID componentid);
	void RemoveComponent(UniverseID componentid);
	void RemoveGateConnection(UniverseID gateid, UniverseID othergateid);
	void RemoveHoloMap(void);
	void ReplaceHighwaySpline(UniverseID highwayid, SplineData* splinepoints, uint32_t numsplinepoints, UniverseID holomapid);
	void RevealMap(void);
	void SaveUIUserData(void);
	void SetCheckpointSequence(UniverseID checkpointid, int32_t sequence);
	void SetClusterBackground(UniverseID clusterid, const char* macroname);
	void SetComponentDescription(UniverseID componentid, const char* desc);
	void SetEditBoxText(const int editboxid, const char* text);
	void SetKnownTo(UniverseID componentid, const char* factionid);
	void SetMapPicking(UniverseID holomapid, bool enable);
	void SetMapRelativeMousePosition(UniverseID holomapid, bool valid, float x, float y);
	void SetObjectForcedRadarVisible(UniverseID objectid, bool value);
	void SetObjectSectorPos(UniverseID objectid, UniverseID sectorid, UIPosRot offset);
	void SetComponentOwner(UniverseID componentid, const char* factionid);
	void SetPositionalOffset(UniverseID positionalid, UIPosRot offset);
	void SetRegionDefinition(UniverseID regionid, const char* definition);
	void SetSelectedMapComponent(UniverseID holomapid, UniverseID componentid);
	void ShowEditorMap(UniverseID holomapid, UniverseID sectorid);
	void SpawnLocalHighwayAtPos(const char* macroname, UniverseID sectorid, UIPosRot offset);
	UniverseID SpawnObjectAtPos2(const char* macroname, UniverseID sectorid, UIPosRot offset, const char* ownerid);
	UniverseID SpawnRegionAtPos(const char* regiondefinition, UniverseID sectorid, UIPosRot offset);
	UniverseID SpawnStationAtPos(const char* macroname, UniverseID sectorid, UIPosRot offset, const char* constructionplanid, const char* ownerid);
	void StartMapBoxSelect(UniverseID holomapid, bool selectenemies);
	void StartPanMap(UniverseID holomapid);
	void StartRotateMap(UniverseID holomapid);
	void StopMapBoxSelect(UniverseID holomapid);
	bool StopPanMap(UniverseID holomapid);
	bool StopRotateMap(UniverseID holomapid);
	void ZoomMap(UniverseID holomapid, float zoomstep);
]]

local menu = {
  name = "Cheat_MapEditorMenu",
  holomap = 0,

  macrosearch = "",
  regiondefinition = "",
  constructionplan = "",
  cpfaction = "player",
  mapname = "",
  exportExtension = C.IsMasterVersion() and "" or "basegame",

  searchindex = {},
  selectedcomponent = 0,
  spawnTableMode = "object",
}

local config = {
  mapFontSize = Helper.standardFontSize,
  optionsLayer = 4,
  backarrow = "table_arrow_inv_left",
  backarrowOffsetX = 3,
  standardFontSize = 10,
  headerTextHeight = 34,
  standardTextHeight = 19,
  standardTextOffsetX = 5,
  font = "Zekton outlined",
  fontBold = "Zekton bold outlined",
  headerFontSize = 13,
  headerTextOffsetX = 5,
  infoFontSize = 9,
  contextFrameLayer = 2,
  mainFrameLayer = 6,
  infoFrameLayer = 5,
  infoFrame2Layer = 4,

  leftBar = {
    { name = "Spawn Object",                    icon = "mapob_poi",       mode = "object" },   -- TEMPTEXT Florian
    { name = "Spawn Construction Plan Station", icon = "mapob_factory",   mode = "station" },  -- TEMPTEXT Florian
    { name = "Spawn Region",                    icon = "mapob_region",    mode = "region" },   -- TEMPTEXT Florian
    { name = "Spawn Local Highway",             icon = "maplegend_hw_01", mode = "highway" },  -- TEMPTEXT Florian
    { name = "Settings",                        icon = "menu_options",    mode = "settings" }, -- TEMPTEXT Florian
  },

  clusterGridEdgeLength = 10000000,
}

-- from gameoptions.lua

config.standardTextProperties = {
  font = config.font,
  fontsize = config.standardFontSize,
  x = config.standardTextOffsetX,
  y = 2,
}

config.headerTextProperties = {
  font = config.fontBold,
  fontsize = config.headerFontSize,
  x = config.headerTextOffsetX,
  y = 6,
  minRowHeight = config.headerTextHeight,
  titleColor = Color["row_title"],
}

menu.mapEditorSettings = {
  gamestartid = option.id,
  sectors = { all = true },
}

function menu.displayMapEditor()
  Helper.clearDataForRefresh(menu, config.optionsLayer)
  menu.selectedOption = nil

  menu.currentOption = "mapeditor"

  local frame = menu.createOptionsFrame()

  local titletable = frame:addTable(2,
    { tabOrder = 2, x = menu.table.x, y = menu.table.y, width = menu.table.width, skipTabChange = true })
  titletable:setColWidth(1, menu.table.arrowColumnWidth, false)

  -- title
  local row = titletable:addRow(true, { fixed = true })
  row[1]:setBackgroundColSpan(2)
  row[1]:createButton({ height = config.headerTextHeight }):setIcon(config.backarrow, { x = config.backarrowOffsetX })
  row[1].handlers.onClick = function() return menu.onCloseElement("back") end
  row[2]:createText(ReadText(1021, 8100), config.headerTextProperties)

  local offsety = titletable.properties.y + titletable:getVisibleHeight() + Helper.borderSize
  local height = menu.table.height - (titletable:getVisibleHeight() + Helper.borderSize)

  local optiontable = frame:addTable(3,
    { tabOrder = 1, x = menu.table.x, y = offsety, width = menu.table.width, maxVisibleHeight = height })
  optiontable:setColWidth(2, menu.table.arrowColumnWidth, false)
  optiontable:setColWidthPercent(3, 60)
  optiontable:setDefaultCellProperties("button", { height = config.standardTextHeight })
  optiontable:setDefaultComplexCellProperties("button", "text",
    { x = config.standardTextOffsetX, fontsize = config.standardFontSize })
  optiontable:setDefaultCellProperties("dropdown", { height = config.standardTextHeight })
  optiontable:setDefaultComplexCellProperties("dropdown", "text",
    { x = config.standardTextOffsetX, fontsize = config.standardFontSize })
  optiontable:setDefaultCellProperties("slidercell", { height = config.standardTextHeight })
  optiontable:setDefaultComplexCellProperties("slidercell", "text",
    { x = config.standardTextOffsetX, fontsize = config.standardFontSize })

  local buf = ffi.new("CustomGameStartStringPropertyState[1]")
  local mapeditormacro = ffi.string(C.GetCustomGameStartStringProperty(menu.mapEditorSettings.gamestartid, "galaxy", buf))
  if mapeditormacro == "editor_empty_galaxy_macro" then
    mapeditormacro = ""
  end

  local mapeditormacrooptions = {}
  table.insert(mapeditormacrooptions,
    { id = "editor_galaxy_macro", text = ReadText(1001, 11780), icon = "", displayremoveoption = false })
  table.insert(mapeditormacrooptions,
    { id = "xu_ep2_universe_macro", text = ReadText(1001, 11789), icon = "", displayremoveoption = false })
  table.insert(mapeditormacrooptions,
    { id = "swi_galaxy_macro", text = "Star Wars Interworlds", icon = "", displayremoveoption = false })
  local n = C.GetNumMapEditorMacros()
  if n > 0 then
    local buf = ffi.new("const char*[?]", n)
    n = C.GetMapEditorMacros(buf, n)
    for i = 0, n - 1 do
      local macro = ffi.string(buf[i])
      local name = GetMacroData(macro, "name")
      table.insert(mapeditormacrooptions,
        { id = macro, text = name, icon = "", displayremoveoption = false, mouseovertext = macro })
    end
  end

  local row = optiontable:addRow(true, {})
  row[1]:createText(ReadText(1001, 11781) .. ReadText(1001, 120), config.standardTextProperties)
  row[2]:setColSpan(2):createDropDown(mapeditormacrooptions, { startOption = mapeditormacro }):setTextProperties({
    x =
        Helper.standardTextOffsetx
  })
  row[2].handlers.onDropDownConfirmed = function(_, id)
    menu.callbackGamestartGalaxyMacro(menu.mapEditorSettings.gamestartid, "galaxy", id); menu.refresh()
  end

  local row = optiontable:addRow(true, {})
  row[2]:setColSpan(2):createButton({ active = mapeditormacro ~= "" }):setText(ReadText(1001, 11782),
    { halign = "center" })
  row[2].handlers.onClick = function()
    Helper.addDelayedOneTimeCallbackOnUpdate(function() NewGame(menu.mapEditorSettings.gamestartid) end, true,
      getElapsedTime() + 0.1); menu.displayInit()
  end

  optiontable:addEmptyRow()

  local clusteroptions = {}
  local n = C.GetNumCatalogMacros("cluster")
  if n > 0 then
    local buf = ffi.new("const char*[?]", n)
    n = C.GetCatalogMacros(buf, n, "cluster")
    for i = 0, n - 1 do
      local macro = ffi.string(buf[i])
      local name, sectors = GetMacroData(macro, "name", "sectors")
      if #sectors == 1 then
        name = GetMacroData(sectors[1], "name")
      end

      table.insert(clusteroptions,
        { id = macro, text = name, icon = "", displayremoveoption = false, mouseovertext = macro })
    end
  end
  table.sort(clusteroptions, function(a, b) return a.text < b.text end)

  local row = optiontable:addRow(true, {})
  row[1]:createText(ReadText(1001, 11783) .. ReadText(1001, 120), config.standardTextProperties)
  row[2]:setColSpan(2):createDropDown(clusteroptions, { startOption = menu.mapEditorSettings.cluster or "" })
      :setTextProperties({ x = Helper.standardTextOffsetx })
  row[2].handlers.onDropDownConfirmed = function(_, id)
    menu.mapEditorSettings.cluster = id; menu.refresh()
  end

  local sectoroptions = {}
  if menu.mapEditorSettings.cluster then
    local sectors = GetMacroData(menu.mapEditorSettings.cluster, "sectors") or {}
    table.sort(sectors, Helper.sortMacroName)
    if menu.mapEditorSettings.sectors["all"] then
      for _, sector in ipairs(sectors) do
        menu.mapEditorSettings.sectors[sector] = true
      end
    end

    local row = optiontable:addRow(true, {})
    row[2]:createCheckBox(function() return menu.mapEditorSettings.sectors["all"] end)
    row[2].handlers.onClick = function(_, value) menu.checkboxMapEditorSector("all", value) end
    row[3]:createText(ReadText(1001, 11784))

    for _, sector in ipairs(sectors) do
      local row = optiontable:addRow(true, {})
      row[2]:createCheckBox(function()
        return menu.mapEditorSettings.sectors[sector] or
            menu.mapEditorSettings.sectors["all"]
      end)
      row[2].handlers.onClick = function(_, value) menu.checkboxMapEditorSector(sector, value) end
      row[3]:createText(GetMacroData(sector, "name"), { mouseOverText = sector })
    end
  end

  local row = optiontable:addRow(true, {})
  row[2]:setColSpan(2):createButton({ active = menu.buttonMapEditorClusterCopyActive }):setText(ReadText(1001, 11782),
    { halign = "center" })
  row[2].handlers.onClick = menu.startMapEditorWithCopy

  optiontable:setTopRow(menu.preselectTopRow)
  menu.preselectTopRow = nil
  menu.preselectOption = nil

  titletable.properties.nextTable = optiontable.index
  optiontable.properties.prevTable = titletable.index

  frame:display()
end

function menu.startMapEditorWithCopy()
  C.SetCustomGameStartStringProperty(menu.mapEditorSettings.gamestartid, "galaxy", "editor_empty_galaxy_macro")

  local sectors = ""
  if menu.mapEditorSettings.sectors and (menu.mapEditorSettings.sectors["all"] ~= true) then
    for sector, value in pairs(menu.mapEditorSettings.sectors) do
      if value then
        if sectors == "" then
          C.SetCustomGameStartStringProperty(menu.mapEditorSettings.gamestartid, "sector", sector)
        else
          sectors = sectors .. " "
        end
        sectors = sectors .. sector
      end
    end
  else
    local sectors = GetMacroData(menu.mapEditorSettings.cluster, "sectors") or {}
    C.SetCustomGameStartStringProperty(menu.mapEditorSettings.gamestartid, "sector", sectors[1] or "")
  end

  local numparams = 2
  local params = ffi.new("NewGameParameter[?]", numparams)
  params[0].key = Helper.ffiNewString("cluster")
  params[0].value = Helper.ffiNewString(menu.mapEditorSettings.cluster)
  params[1].key = Helper.ffiNewString("sectors")
  params[1].value = Helper.ffiNewString(sectors)

  Helper.addDelayedOneTimeCallbackOnUpdate(
    function() C.NewGame(menu.mapEditorSettings.gamestartid, numparams, params) end, true, getElapsedTime() + 0.1)
  menu.displayInit()
end

function menu.buttonMapEditorClusterCopyActive()
  if not menu.mapEditorSettings.cluster then
    return false
  end
  for _, value in pairs(menu.mapEditorSettings.sectors) do
    if value then
      return true
    end
  end
  return false
end

function menu.checkboxMapEditorSector(sector, value)
  menu.mapEditorSettings.sectors[sector] = value
  if sector == "all" then
    local sectors = GetMacroData(menu.mapEditorSettings.cluster, "sectors") or {}
    for _, sector in ipairs(sectors) do
      menu.mapEditorSettings.sectors[sector] = value
    end
  else
    if not value then
      menu.mapEditorSettings.sectors["all"] = false
    end
  end
end

-- end from gameoptions.lua

__CORE_DETAILMONITOR_MAPEDITOR = __CORE_DETAILMONITOR_MAPEDITOR or {
  opacity = 98,
}

local function init()
  Menus = Menus or {}
  table.insert(Menus, menu)
  --[[   if Helper then
    Helper.registerMenu(menu)
  end ]]
end

function menu.cleanup()
  menu.noupdate = nil
  if menu.holomap ~= 0 then
    C.RemoveHoloMap()
    menu.holomap = 0
  end
  menu.activatemap = nil

  menu.selectedcomponent = 0
  menu.selectedComponentSector = nil
  menu.selectedComponentOffset = nil
end

function menu.onShowMenu()
  menu.sideBarWidth = Helper.scaleX(Helper.sidebarWidth)

  if menu.mapname == "" then
    local galaxy = C.GetPlayerGalaxyID()
    local galaxymacro = GetComponentData(ConvertStringToLuaID(tostring(galaxy)), "macro")
    menu.mapname = string.match(galaxymacro, "(.-)_galaxy_macro") or ""
    local cropbasename = string.match(menu.mapname, "^basegame_map_(.+)")
    if cropbasename then
      menu.mapname = cropbasename
    end
  end

  menu.objects = {}
  local n = C.GetNumMapEditorObjectList()
  if n > 0 then
    local buf = ffi.new("UniverseID[?]", n)
    n = C.GetMapEditorObjectList(buf, n)
    for i = 0, n - 1 do
      local id = buf[i]
      C.SetObjectForcedRadarVisible(id, true)
      C.SetKnownTo(id, "player")
      table.insert(menu.objects, { id = id })
    end
  end

  menu.getRegionDefinitions()
  menu.getConstructionPlans()
  menu.getFactions()

  -- map
  menu.rendertargetWidth = Helper.viewWidth
  menu.rendertargetHeight = Helper.viewHeight

  C.RevealMap()

  menu.displayMenu()
end

function menu.getRegionDefinitions()
  menu.regiondefinitions = {}
  menu.regiondefinitionbyref = {}
  local n = C.GetNumRegionDefinitions()
  if n > 0 then
    local buf = ffi.new("RegionDefinition[?]", n)
    n = C.GetRegionDefinitions(buf, n)
    for i = 0, n - 1 do
      local entry = {}

      entry.id = ffi.string(buf[i].id)
      entry.size = { x = 2 * buf[i].size.x, y = 2 * buf[i].size.y, z = 2 * buf[i].size.z }
      entry.density = buf[i].density
      entry.speed = buf[i].speed
      entry.rotationSpeed = buf[i].rotationSpeed
      entry.defaultNoiseScale = buf[i].defaultNoiseScale
      entry.defaultMinNoiseValue = buf[i].defaultMinNoiseValue
      entry.defaultMaxNoiseValue = buf[i].defaultMaxNoiseValue

      entry.fields = {}
      local buf_fields = ffi.new("RegionField[?]", buf[i].numfields)
      local numfields = C.GetRegionFields(buf_fields, buf[i].numfields, entry.id)
      for j = 0, numfields - 1 do
        local field = {}

        field.fieldtype = ffi.string(buf_fields[j].fieldtype)
        field.groupref = ffi.string(buf_fields[j].groupref)

        table.insert(entry.fields, field)
      end

      entry.boundaries = {}
      local buf_boundaries = ffi.new("RegionBoundary[?]", buf[i].numboundaries)
      local numboundaries = C.GetRegionBoundaries(buf_boundaries, buf[i].numboundaries, entry.id)
      for j = 0, numboundaries - 1 do
        local boundary = {}

        boundary.classid = ffi.string(buf_boundaries[j].classid)
        boundary.halfsize = { x = buf_boundaries[j].size.x, y = buf_boundaries[j].size.y, z = buf_boundaries[j].size.z }
        boundary.inverted = buf_boundaries[j].inverted

        table.insert(entry.boundaries, boundary)
      end

      entry.resources = {}
      local buf_resources = ffi.new("RegionResource[?]", buf[i].numresources)
      local numresources = C.GetRegionResources(buf_resources, buf[i].numresources, entry.id)
      for j = 0, numresources - 1 do
        local resource = {}

        resource.ware = ffi.string(buf_resources[j].wareid)
        resource.yield = ffi.string(buf_resources[j].yield)

        table.insert(entry.resources, resource)
      end

      table.insert(menu.regiondefinitions, entry)
      menu.regiondefinitionbyref[entry.id] = entry
    end
  end
end

function menu.getConstructionPlans()
  menu.constructionplans = {}
  local n = C.GetNumConstructionPlans()
  local buf = ffi.new("UIConstructionPlan[?]", n)
  n = C.GetConstructionPlans(buf, n)
  local ischeatversion = IsCheatVersion()
  for i = 0, n - 1 do
    local id = ffi.string(buf[i].id)
    local source = ffi.string(buf[i].source)
    if source ~= "local" then
      local isvalid = true
      local mouseovertext
      local numinvalidpatches = ffi.new("uint32_t[?]", 1)
      if C.IsConstructionPlanValid(id, numinvalidpatches) then
        mouseovertext = id
      else
        isvalid = false
        local numpatches = numinvalidpatches[0]
        local patchbuf = ffi.new("InvalidPatchInfo[?]", numpatches)
        numpatches = C.GetConstructionPlanInvalidPatches(patchbuf, numpatches, id)
        mouseovertext = ReadText(1001, 2685) .. ReadText(1001, 120) -- Missing, old or disabled extensions:
        for j = 0, numpatches - 1 do
          if j > 3 then
            mouseovertext = mouseovertext .. "\n- ..."
            break
          end
          mouseovertext = mouseovertext ..
              "\n- " ..
              ffi.string(patchbuf[j].name) ..
              " (" .. ffi.string(patchbuf[j].id) .. " - " .. ffi.string(patchbuf[j].requiredversion) .. ")"
          if patchbuf[j].state == 2 then
            mouseovertext = mouseovertext .. " " .. ReadText(1001, 2686)
          elseif patchbuf[j].state == 3 then
            mouseovertext = mouseovertext .. " " .. ReadText(1001, 2687)
          elseif patchbuf[j].state == 4 then
            mouseovertext = mouseovertext ..
                " " .. string.format(ReadText(1001, 2688), ffi.string(patchbuf[j].installedversion))
          end
        end
      end

      table.insert(menu.constructionplans,
        { id = id, text = ffi.string(buf[i].name), icon = "", displayremoveoption = false, active = isvalid, mouseovertext = (mouseovertext or "") })
    end
  end
  table.sort(menu.constructionplans, function(a, b) return a.text < b.text end)
end

function menu.getFactions()
  -- all factions
  menu.factions = {}
  local n = C.GetNumAllFactions(false)
  local buf = ffi.new("const char*[?]", n)
  n = C.GetAllFactions(buf, n, false)
  for i = 0, n - 1 do
    local id = ffi.string(buf[i])
    if id ~= "player" then
      table.insert(menu.factions, { id = id, text = GetFactionData(id, "name"), icon = "", displayremoveoption = false })
    end
  end
  table.sort(menu.factions, function(a, b) return a.text < b.text end)
  -- player faction in front
  table.insert(menu.factions, 1, { id = "player", text = "Player", icon = "", displayremoveoption = false }) -- TEMPTEXT Florian
end

function menu.displayMenu()
  menu.createMainFrame()
  menu.createInfoFrame()
end

function menu.createMainFrame()
  menu.createMainFrameRunning = true
  -- remove old data
  Helper.removeAllWidgetScripts(menu, config.mainFrameLayer)

  menu.mainFrame = Helper.createFrameHandle(menu, {
    layer = config.mainFrameLayer,
    standardButtons = { back = true, close = true },
    width = Helper.viewWidth,
    height = Helper.viewHeight,
    x = 0,
    y = 0,
  })

  -- rendertarget
  local alpha = __CORE_DETAILMONITOR_MAPEDITOR.opacity
  menu.mainFrame:addRenderTarget({
    width = menu.rendertargetWidth,
    height = menu.rendertargetHeight,
    x = 0,
    y = 0,
    scaling = false,
    alpha =
        alpha,
    clear = false
  })

  -- left bar
  menu.createSideBar(menu.mainFrame)

  menu.mainFrame:display()
end

function menu.refreshMainFrame()
  if not menu.createMainFrameRunning then
    menu.createMainFrame()
  end
end

function menu.createSideBar(frame)
  local spacingHeight = menu.sideBarWidth / 4
  local defaultInteractiveObject = menu.spawnTableMode == nil
  local ftable = frame:addTable(1,
    {
      tabOrder = 21,
      width = menu.sideBarWidth,
      x = Helper.frameBorder,
      y = Helper.frameBorder,
      scaling = false,
      borderEnabled = false,
      reserveScrollBar = false,
      defaultInteractiveObject =
          defaultInteractiveObject
    })

  local leftbar = config.leftBar
  for _, entry in ipairs(leftbar) do
    if (entry.condition == nil) or entry.condition() then
      if not entry.spacing then
        entry.active = true
        if entry.active then
          local selectedmode = false
          if type(entry.mode) == "table" then
            for _, mode in ipairs(entry) do
              if mode == menu.spawnTableMode then
                selectedmode = true
                break
              end
            end
          else
            if entry.mode == menu.spawnTableMode then
              selectedmode = true
            end
          end
        end
      end
    end
  end

  for _, entry in ipairs(leftbar) do
    if (entry.condition == nil) or entry.condition() then
      if entry.spacing then
        local row = ftable:addRow(false, { fixed = true })
        row[1]:createIcon("mapst_seperator_line", { width = menu.sideBarWidth, height = spacingHeight })
      else
        local mode = entry.mode
        if type(entry.mode) == "table" then
          mode = mode[1]
        end
        local row = ftable:addRow(true, { fixed = true })
        local bgcolor = Color["row_title_background"]
        if type(entry.mode) == "table" then
          for _, mode in ipairs(entry) do
            if mode == menu.spawnTableMode then
              bgcolor = Color["row_background_blue"]
              break
            end
          end
        else
          if entry.mode == menu.spawnTableMode then
            bgcolor = Color["row_background_blue"]
          end
        end
        local color = Color["icon_normal"]

        row[1]:createButton({
          active = entry.active,
          height = menu.sideBarWidth,
          bgColor = bgcolor,
          mouseOverText = entry
              .name,
          helpOverlayID = entry.helpOverlayID,
          helpOverlayText = entry.helpOverlayText
        }):setIcon(entry.icon,
          { color = color })
        row[1].handlers.onClick = function() return menu.buttonToggleSpawnTable(mode) end
      end
    end
  end
end

function menu.createInfoFrame()
  menu.createInfoFrameRunning = true
  -- remove old data
  Helper.removeAllWidgetScripts(menu, config.infoFrameLayer)

  menu.infoFrame = Helper.createFrameHandle(menu, {
    layer = config.infoFrameLayer,
    standardButtons = {},
    width = Helper.viewWidth,
    height = Helper.viewHeight,
    x = 0,
    y = 0,
  })

  menu.createSpawnTable(menu.infoFrame)
  menu.createComponentTable(menu.infoFrame)
  menu.createExportTable(menu.infoFrame)

  menu.infoFrame:display()
end

function menu.refreshInfoFrame()
  if not menu.createInfoFrameRunning then
    menu.createInfoFrame()
  end
end

function menu.createSpawnTable(frame)
  local numcols = 3
  local ftable = frame:addTable(numcols,
    {
      tabOrder = 1,
      width = 500,
      x = Helper.frameBorder + menu.sideBarWidth + 2 * Helper.borderSize,
      y = Helper
          .frameBorder
    })

  if menu.spawnTableMode == "object" then
    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText("Spawn Object", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

    local row = ftable:addRow(true, { fixed = true })
    row[1]:setColSpan(numcols):createEditBox({ height = Helper.standardTextHeight, defaultText = "Find macro..." })
        :setText(menu.macrosearch) -- TEMPTEXT Florian
    row[1].handlers.onTextChanged = function(_, text, textchanged)
      menu.macrosearch = text; menu.refreshInfoFrame2()
    end
    row[1].handlers.onEditBoxActivated = function()
      menu.showMacroSuggestions = true; menu.refreshInfoFrame2()
    end
    row[1].handlers.onEditBoxDeactivated = function()
      menu.showMacroSuggestions = false; menu.refreshInfoFrame2(); menu.refreshInfoFrame()
    end

    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText(menu.macroSearchText, { color = menu.macroSearchColor })

    local searchhistory = {}
    for macro, name in pairs(menu.searchindex) do
      table.insert(searchhistory, { macro = macro, name = name })
    end
    table.sort(searchhistory, Helper.sortName)

    ftable:addEmptyRow()

    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText("History", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

    if #searchhistory > 0 then
      for _, entry in ipairs(searchhistory) do
        local row = ftable:addRow(true, {})
        row[1]:setColSpan(numcols):createButton({}):setText(entry.name .. " (" .. entry.macro .. ")")
        row[1].handlers.onClick = function() menu.macrosearch = entry.macro end
      end
    else
      local row = ftable:addRow(true, {})
      row[1]:setColSpan(numcols):createText("--- No entries ---") -- TEMPTEXT Florian
    end

    local row = ftable:addRow(true, {})
    row[3]:createButton({}):setText("Clear", { halign = "center" }) -- TEMPTEXT Florian
    row[3].handlers.onClick = function()
      menu.searchindex = {}; menu.refreshInfoFrame()
    end
  elseif menu.spawnTableMode == "region" then
    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText("Spawn Region", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

    local regionoptions = {}
    for _, definition in ipairs(menu.regiondefinitions) do
      table.insert(regionoptions, { id = definition.id, text = definition.id, icon = "", displayremoveoption = false })
    end

    local row = ftable:addRow(true, {})
    row[1]:createText("Region Definition:") -- TEMPTEXT Florian
    row[2]:setColSpan(2):createDropDown(regionoptions,
      { height = Helper.standardTextHeight, startOption = menu.regiondefinition }):setTextProperties({
      fontsize = config
          .mapFontSize
    })
    row[2].handlers.onDropDownConfirmed = function(_, id) menu.regiondefinition = id end

    ftable:addEmptyRow()

    local row = ftable:addRow(nil, {})
    row[1]:setColSpan(numcols):createText(menu.regionSearchText)
  elseif menu.spawnTableMode == "station" then
    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText("Spawn Construction Plan Station", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

    local row = ftable:addRow(true, {})
    row[1]:createText("Construction Plan:") -- TEMPTEXT Florian
    row[2]:setColSpan(2):createDropDown(menu.constructionplans,
      { height = Helper.standardTextHeight, startOption = menu.constructionplan }):setTextProperties({
      fontsize = config
          .mapFontSize
    })
    row[2].handlers.onDropDownConfirmed = function(_, id) menu.constructionplan = id end

    local row = ftable:addRow(true, {})
    row[1]:createText("Station Owner:") -- TEMPTEXT Florian
    row[2]:setColSpan(2):createDropDown(menu.factions,
      { height = Helper.standardTextHeight, startOption = menu.cpfaction }):setTextProperties({
      fontsize = config
          .mapFontSize
    })
    row[2].handlers.onDropDownConfirmed = function(_, id) menu.cpfaction = id end

    ftable:addEmptyRow()

    local row = ftable:addRow(nil, {})
    row[1]:setColSpan(numcols):createText(menu.stationSearchText)
  elseif menu.spawnTableMode == "settings" then
    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText("Settings", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

    local row = ftable:addRow(true, {})
    row[1]:createText("Map Opacity:") -- TEMPTEXT Florian
    row[2]:setColSpan(2):createSliderCell({
      height = Helper.standardTextHeight,
      min = 0,
      max = 100,
      start = __CORE_DETAILMONITOR_MAPEDITOR.opacity,
      hideMaxValue = true,
    })
    row[2].handlers.onSliderCellChanged = function(_, value)
      __CORE_DETAILMONITOR_MAPEDITOR.opacity = value; C.SaveUIUserData(); menu.refreshMainFrame()
    end
  elseif menu.spawnTableMode == "highway" then
    local row = ftable:addRow(nil, { fixed = true })
    row[1]:setColSpan(numcols):createText("Spawn Local Highway", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

    local row = ftable:addRow(nil, {})
    row[1]:setColSpan(numcols):createText("Ctrl+RMB on the map to spawn a local highway") -- TEMPTEXT Florian
  end
end

function menu.macroSearchText()
  if C.FindMacro(menu.macrosearch) then
    local name = GetMacroData(menu.macrosearch, "name")
    menu.searchindex[string.lower(menu.macrosearch)] = name

    local class = ffi.string(C.GetMacroClass(menu.macrosearch))
    local postfix = ""
    if IsMacroClass(menu.macrosearch, "object") then
      postfix = "\n\nCtrl+RMB on the map to spawn this object"                                     -- TEMPTEXT Florian
    end
    return ColorText["text_positive"] .. "[Found]\27X " .. name .. "\nClass: " .. class .. postfix -- TEMPTEXT Florian
  end
  return menu.macrosearch .. "\n \n \n "
end

function menu.regionSearchText()
  if menu.regiondefinition ~= "" then
    local def = menu.regiondefinitionbyref[menu.regiondefinition]
    if def then
      local text = ""

      text = text ..
          "Bounding Box: " ..
          tostring(def.size.x) ..
          "m / " ..
          tostring(def.size.y) ..
          "m / " .. tostring(def.size.z) .. "m" -- TEMPTEXT Florian
      text = text ..
          "\nDensity: " ..
          def.density -- TEMPTEXT Florian
      text = text ..
          "\nSpeed: " ..
          def.speed ..
          "m/s? - unused?" -- TEMPTEXT Florian
      text = text ..
          "\nRotation Speed: " ..
          def.rotationSpeed ..
          "rad/s? - unused?" -- TEMPTEXT Florian
      text = text ..
          "\nDefault Noise Scale: " ..
          def.defaultNoiseScale -- TEMPTEXT Florian
      text = text ..
          "\nDefault Min Noise Value: " ..
          def.defaultMinNoiseValue -- TEMPTEXT Florian
      text = text ..
          "\nDefault Max Noise Value: " ..
          def.defaultMaxNoiseValue -- TEMPTEXT Florian

      text = text ..
          "\n\nBoundaries:" -- TEMPTEXT Florian
      for _, boundary in ipairs(def.boundaries) do
        local size = ""
        if boundary.classid == "sphere" then
          size = "r = " ..
              boundary.halfsize.x ..
              "m" -- TEMPTEXT Florian
        elseif boundary.classid == "cylinder" then
          size = "r = " ..
              boundary.halfsize.x ..
              "m, l = " .. 2 * boundary.halfsize.y .. "m" -- TEMPTEXT Florian
        elseif boundary.classid == "box" then
          size = "x = " ..
              2 * boundary.halfsize.x ..
              "m, y = " ..
              2 * boundary.halfsize.y ..
              "m, z = " .. 2 * boundary.halfsize.z .. "m" -- TEMPTEXT Florian
        elseif boundary.classid == "splinetube" then
          size = "tube r = " ..
              boundary.halfsize.x ..
              "m" -- TEMPTEXT Florian
        end

        text = text ..
            "\n   Type: " ..
            boundary.classid ..
            " (" ..
            size .. ")" .. (boundary.inverted and " - inverted" or "") -- TEMPTEXT Florian
      end

      text = text .. "\n\nFields:"                                                           -- TEMPTEXT Florian
      for _, field in ipairs(def.fields) do
        text = text .. "\n   Type: " .. field.fieldtype .. " - GroupRef: " .. field.groupref -- TEMPTEXT Florian
      end

      text = text .. "\n\nResources:"                                                   -- TEMPTEXT Florian
      for _, resource in ipairs(def.resources) do
        text = text .. "\n   Ware: " .. resource.ware .. " - Yield: " .. resource.yield -- TEMPTEXT Florian
      end

      text = text .. "\n\nCtrl+RMB on the map to spawn this region" -- TEMPTEXT Florian

      return text
    end
  end
  return ""
end

function menu.stationSearchText()
  if menu.constructionplan ~= "" then
    return "\nCtrl+RMB on the map to spawn this station" -- TEMPTEXT Florian
  end
  return ""
end

function menu.macroSearchColor()
  if C.FindMacro(menu.macrosearch) then
    return Color["text_normal"]
  end
  return Color["text_inactive"]
end

function menu.createComponentTable(frame)
  local width = 500

  local numcols = 3
  local ftable = frame:addTable(numcols,
    { tabOrder = 2, width = width, x = Helper.viewWidth - width - Helper.frameBorder, y = Helper.frameBorder })

  if menu.gateconnection ~= menu.selectedcomponent then
    menu.gateconnection = nil
  end

  local row = ftable:addRow(nil, { fixed = true })
  row[1]:setColSpan(numcols):createText("Selected Component", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

  if menu.selectedcomponent ~= 0 then
    if C.IsComponentClass(menu.selectedcomponent, "object") then
      menu.selectedComponentSector = C.GetContextByClass(menu.selectedcomponent, "sector", false)
      menu.selectedComponentOffset = C.GetObjectPositionInSector(menu.selectedcomponent)

      menu.addNameRows(ftable, menu.selectedcomponent)

      menu.addObjectOffsetRow(ftable, "X", "x", "m")               -- TEMPTEXT Florian
      menu.addObjectOffsetRow(ftable, "Y", "y", "m")               -- TEMPTEXT Florian
      menu.addObjectOffsetRow(ftable, "Z", "z", "m")               -- TEMPTEXT Florian
      menu.addObjectOffsetRow(ftable, "Yaw", "yaw", "°", true)     -- TEMPTEXT Florian
      menu.addObjectOffsetRow(ftable, "Pitch", "pitch", "°", true) -- TEMPTEXT Florian
      menu.addObjectOffsetRow(ftable, "Roll", "roll", "°", true)   -- TEMPTEXT Florian

      ftable:addEmptyRow()

      local luaselectedcomponent = ConvertStringToLuaID(tostring(menu.selectedcomponent))
      local owner, destination, destinationsector = GetComponentData(luaselectedcomponent, "owner", "destination",
        "destinationsector")

      local row = ftable:addRow(true, {})
      row[1]:createText("Owner:") -- TEMPTEXT Florian
      row[2]:setColSpan(2):createDropDown(menu.factions, { height = Helper.standardTextHeight, startOption = owner })
          :setTextProperties({ fontsize = config.mapFontSize })
      row[2].handlers.onDropDownConfirmed = function(_, id) C.SetComponentOwner(menu.selectedcomponent, id) end

      if C.IsComponentClass(menu.selectedcomponent, "checkpoint") then
        ftable:addEmptyRow()

        local row = ftable:addRow(true, {})
        row[1]:setColSpan(2):createText("Sequence:") -- TEMPTEXT Florian
        local editbox = row[3]:createEditBox({ height = Helper.standardTextHeight }):setText(C.GetCheckpointSequence(
          menu.selectedcomponent))
        row[3].handlers.onTextChanged = function(_, text, textchanged)
          if (text ~= "") and tonumber(text) then
            C
                .SetCheckpointSequence(menu.selectedcomponent, tonumber(text))
          end
        end
        row[3].handlers.onEditBoxDeactivated = function(_, text, textchanged)
          C.SetEditBoxText(editbox.id,
            tostring(C.GetCheckpointSequence(menu.selectedcomponent)))
        end
      elseif C.IsComponentClass(menu.selectedcomponent, "gate") then
        ftable:addEmptyRow()

        if destination then
          local name = GetComponentData(destinationsector, "name")

          local row = ftable:addRow(true, {})
          row[1]:setColSpan(2):createText("Destination:") -- TEMPTEXT Florian
          row[3]:createText(name)

          local row = ftable:addRow(true, {})
          row[3]:createButton({}):setText("Remove Connection", { halign = "center" }) -- TEMPTEXT Florian
          row[3].handlers.onClick = function()
            C.RemoveGateConnection(menu.selectedcomponent, C.ConvertStringTo64Bit(tostring(destination))); menu
                .refreshInfoFrame()
          end
        else
          local row = ftable:addRow(true, {})
          row[1]:setColSpan(3):createButton({}):setText("Add Gate Connection") -- TEMPTEXT Florian
          row[1].handlers.onClick = function()
            menu.gateconnection = menu.selectedcomponent; menu.refreshInfoFrame()
          end

          if menu.gateconnection then
            local row = ftable:addRow(true, {})
            row[1]:setColSpan(3):createText("Select another inactive gate to set the connection", { wordwrap = true }) -- TEMPTEXT Florian
          end
        end
      end

      ftable:addEmptyRow()

      local row = ftable:addRow(true, {})
      row[3]:createButton({}):setText("Remove", { halign = "center" }) -- TEMPTEXT Florian
      row[3].handlers.onClick = function()
        C.RemoveComponent(menu.selectedcomponent); menu.selectedcomponent = 0; menu.refreshInfoFrame()
      end
    elseif C.IsComponentClass(menu.selectedcomponent, "region") then
      menu.selectedComponentCluster = C.GetContextByClass(menu.selectedcomponent, "cluster", false)
      menu.selectedComponentOffset = C.GetPositionalOffset(menu.selectedcomponent, 0)

      menu.addPositionalOffsetRow(ftable, "X", "x", "m")               -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Y", "y", "m")               -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Z", "z", "m")               -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Yaw", "yaw", "°", true)     -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Pitch", "pitch", "°", true) -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Roll", "roll", "°", true)   -- TEMPTEXT Florian

      ftable:addEmptyRow()

      local regionoptions = {}
      for _, definition in ipairs(menu.regiondefinitions) do
        table.insert(regionoptions, { id = definition.id, text = definition.id, icon = "", displayremoveoption = false })
      end

      local row = ftable:addRow(true, {})
      row[1]:createText("Region Definition:") -- TEMPTEXT Florian
      row[2]:setColSpan(2):createDropDown(regionoptions,
        { height = Helper.standardTextHeight, startOption = ffi.string(C.GetRegionDefinition(menu.selectedcomponent)) })
          :setTextProperties({ fontsize = config.mapFontSize })
      row[2].handlers.onDropDownConfirmed = function(_, id) C.SetRegionDefinition(menu.selectedcomponent, id) end

      ftable:addEmptyRow()

      local row = ftable:addRow(true, {})
      row[3]:createButton({}):setText("Remove", { halign = "center" }) -- TEMPTEXT Florian
      row[3].handlers.onClick = function()
        C.RemoveComponent(menu.selectedcomponent); menu.selectedcomponent = 0; menu.refreshInfoFrame()
      end
    elseif C.IsComponentClass(menu.selectedcomponent, "sector") then
      menu.selectedComponentCluster = C.GetContextByClass(menu.selectedcomponent, "cluster", false)
      menu.selectedComponentOffset = C.GetPositionalOffset(menu.selectedcomponent, 0)
      local selectedComponentClusterOffset = C.GetPositionalOffset(menu.selectedComponentCluster, 0)
      local q, r = menu.snapToClusterGrid(selectedComponentClusterOffset)
      menu.selectedComponentClusterGridOffset = { q = q, r = r }

      local row = ftable:addRow(nil, {})
      row[1]:setColSpan(numcols):createText("Sector", Helper.subHeaderTextProperties) -- TEMPTEXT Florian
      menu.addNameRows(ftable, menu.selectedcomponent)

      menu.addPositionalOffsetRow(ftable, "X", "x", "m")               -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Y", "y", "m")               -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Z", "z", "m")               -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Yaw", "yaw", "°", true)     -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Pitch", "pitch", "°", true) -- TEMPTEXT Florian
      menu.addPositionalOffsetRow(ftable, "Roll", "roll", "°", true)   -- TEMPTEXT Florian

      ftable:addEmptyRow()

      local row = ftable:addRow(true, {})
      row[3]:createButton({ active = function() return not C.IsPlayerContext(menu.selectedcomponent) end }):setText(
        "Remove", { halign = "center" }) -- TEMPTEXT Florian
      row[3].handlers.onClick = function()
        C.RemoveComponent(menu.selectedcomponent); menu.selectedcomponent = 0; menu.refreshInfoFrame(); menu.activatemap = true
      end

      local row = ftable:addRow(nil, {})
      row[1]:setColSpan(numcols):createText("Cluster", Helper.subHeaderTextProperties) -- TEMPTEXT Florian
      menu.addNameRows(ftable, menu.selectedComponentCluster)

      menu.addClusterOffsetRow(ftable, "X", "q") -- TEMPTEXT Florian
      menu.addClusterOffsetRow(ftable, "Z", "r") -- TEMPTEXT Florian

      local clusterbackground = ffi.string(C.GetClusterBackground(menu.selectedComponentCluster))
      local clusterbackgroundoptions = {}
      local n = C.GetNumCatalogTemplates("celestialbody")
      if n > 0 then
        local buf = ffi.new("const char*[?]", n)
        n = C.GetCatalogTemplates(buf, n, "celestialbody")
        for i = 0, n - 1 do
          local template = ffi.string(buf[i])

          table.insert(clusterbackgroundoptions,
            { id = template, text = template, icon = "", displayremoveoption = false })
        end
      end
      table.sort(clusterbackgroundoptions, function(a, b) return a.text < b.text end)

      local row = ftable:addRow(true, {})
      row[1]:createText("Cluster Background:") -- TEMPTEXT Florian
      row[2]:setColSpan(2):createDropDown(clusterbackgroundoptions,
        { height = Helper.standardTextHeight, startOption = clusterbackground }):setTextProperties({
        fontsize = config
            .mapFontSize
      })
      row[2].handlers.onDropDownConfirmed = function(_, id)
        return C.SetClusterBackground(menu.selectedComponentCluster,
          id)
      end

      ftable:addEmptyRow()

      local row = ftable:addRow(true, {})
      row[2]:setColSpan(2):createButton({ active = function() return C.GetNumSectors(menu.selectedComponentCluster) < 3 end })
          :setText("Add Sector", { halign = "center" }) -- TEMPTEXT Florian
      row[2].handlers.onClick = function() return menu.buttonAddSector(menu.selectedComponentCluster) end

      ftable:addEmptyRow()

      local row = ftable:addRow(true, {})
      row[3]:createButton({ active = function() return not C.IsPlayerContext(menu.selectedComponentCluster) end })
          :setText("Remove", { halign = "center" }) -- TEMPTEXT Florian
      row[3].handlers.onClick = function()
        C.RemoveComponent(menu.selectedComponentCluster); menu.selectedcomponent = 0; menu.refreshInfoFrame(); menu.activatemap = true
      end
    elseif C.IsComponentClass(menu.selectedcomponent, "highway") then
      local row = ftable:addRow(nil, {})
      row[1]:setColSpan(numcols):createText("Highway", Helper.subHeaderTextProperties) -- TEMPTEXT Florian

      menu.getSpline()
      for i, point in ipairs(menu.splinepoints) do
        local row = ftable:addRow(true, {})
        local name = "Point " .. i -- TEMPTEXT Florian
        if i == 1 then
          name = "Start Point"     -- TEMPTEXT Florian
        elseif i == #menu.splinepoints then
          name = "End Point"       -- TEMPTEXT Florian
        end
        row[1]:createText(name)
        if i ~= #menu.splinepoints then
          row[2]:createButton({}):setText("Add Point", { halign = "center" }) -- TEMPTEXT Florian
          row[2].handlers.onClick = function() menu.buttonAddSplinePoint(i) end
        end
        if (i ~= 1) and (i ~= #menu.splinepoints) then
          row[3]:createButton({}):setText("Remove Point", { halign = "center" }) -- TEMPTEXT Florian
          row[3].handlers.onClick = function()
            menu.getSpline(); table.remove(menu.splinepoints, i); menu.updateSpline()
          end
        end
      end

      ftable:addEmptyRow()

      local row = ftable:addRow(true, {})
      row[3]:createButton({}):setText("Remove", { halign = "center" }) -- TEMPTEXT Florian
      row[3].handlers.onClick = function()
        C.RemoveComponent(menu.selectedcomponent); menu.selectedcomponent = 0; menu.refreshInfoFrame()
      end
    end
  end
end

function menu.buttonAddSplinePoint(i)
  menu.getSpline()

  local offset = {}
  offset.x = (menu.splinepoints[i].offset.x + menu.splinepoints[i + 1].offset.x) / 2
  offset.y = (menu.splinepoints[i].offset.y + menu.splinepoints[i + 1].offset.y) / 2
  offset.z = (menu.splinepoints[i].offset.z + menu.splinepoints[i + 1].offset.z) / 2

  local tangent = {}
  tangent.x = (menu.splinepoints[i].tangent.x + menu.splinepoints[i + 1].tangent.x) / 2
  tangent.y = (menu.splinepoints[i].tangent.y + menu.splinepoints[i + 1].tangent.y) / 2
  tangent.z = (menu.splinepoints[i].tangent.z + menu.splinepoints[i + 1].tangent.z) / 2

  local weight = (menu.splinepoints[i].weight + menu.splinepoints[i + 1].weight) / 2
  local inlength = (menu.splinepoints[i].inlength + menu.splinepoints[i + 1].inlength) / 2
  local outlength = (menu.splinepoints[i].outlength + menu.splinepoints[i + 1].outlength) / 2

  table.insert(menu.splinepoints, i + 1,
    { offset = offset, tangent = tangent, weight = weight, inlength = inlength, outlength = outlength })

  menu.updateSpline()
end

function menu.getSpline()
  menu.splinepoints = {}
  local n = C.GetNumHighwaySplinePoints(menu.selectedcomponent)
  local buf = ffi.new("SplineData[?]", n)
  n = C.GetHighwaySplinePoints(buf, n, menu.selectedcomponent)
  for i = 0, n - 1 do
    local offset = {}
    offset.x = buf[i].offset.x
    offset.y = buf[i].offset.y
    offset.z = buf[i].offset.z

    local tangent = {}
    tangent.x = buf[i].tangent.x
    tangent.y = buf[i].tangent.y
    tangent.z = buf[i].tangent.z

    table.insert(menu.splinepoints,
      {
        offset = offset,
        tangent = tangent,
        weight = buf[i].weight,
        inlength = buf[i].inlength,
        outlength = buf[i]
            .outlength
      })
  end
end

function menu.updateSpline()
  local n = #menu.splinepoints
  local splinedata = ffi.new("SplineData[?]", n)
  for i, point in ipairs(menu.splinepoints) do
    splinedata[i - 1].offset = point.offset
    splinedata[i - 1].tangent = point.tangent
    splinedata[i - 1].weight = point.weight
    splinedata[i - 1].inlength = point.inlength
    splinedata[i - 1].outlength = point.outlength
  end
  C.ReplaceHighwaySpline(menu.selectedcomponent, splinedata, n, menu.holomap)
  menu.refreshInfoFrame();
end

function menu.buttonAddSector(cluster)
  local numsectors = C.GetNumSectors(cluster)

  local offset = ffi.new("UIPosRot")
  offset.x = numsectors * config.clusterGridEdgeLength
  offset.y = 0
  offset.z = numsectors * config.clusterGridEdgeLength

  C.AddSector(cluster, "editor_cluster_001_sector_001_macro", offset)

  menu.activatemap = true
  menu.revealmap = getElapsedTime()
end

function menu.addObjectOffsetRow(ftable, name, coord, suffix, converttodeg)
  local row = ftable:addRow(true, {})
  row[1]:setColSpan(2):createText(name .. ":")
  if converttodeg then
    menu.selectedComponentOffset[coord] = menu.selectedComponentOffset[coord] * 180 / math.pi
  end
  local editbox = row[3]:createEditBox({ height = Helper.standardTextHeight }):setText(Helper.round(
    menu.selectedComponentOffset[coord], 2) .. suffix)
  row[3].handlers.onEditBoxActivated = function()
    C.SetEditBoxText(editbox.id,
      tostring(Helper.round(menu.selectedComponentOffset[coord], 2)))
  end
  row[3].handlers.onTextChanged = function(_, text, textchanged)
    if text ~= "" then menu.selectedComponentOffset[coord] = tonumber(text) end
    C.SetObjectSectorPos(menu.selectedcomponent, menu.selectedComponentSector, menu.selectedComponentOffset)
  end
  row[3].handlers.onEditBoxDeactivated = function()
    C.SetEditBoxText(editbox.id,
      Helper.round(menu.selectedComponentOffset[coord], 2) .. suffix)
  end
end

function menu.addPositionalOffsetRow(ftable, name, coord, suffix, converttodeg)
  local row = ftable:addRow(true, {})
  row[1]:setColSpan(2):createText(name .. ":")
  if converttodeg then
    menu.selectedComponentOffset[coord] = menu.selectedComponentOffset[coord] * 180 / math.pi
  end
  local editbox = row[3]:createEditBox({ height = Helper.standardTextHeight }):setText(Helper.round(
    menu.selectedComponentOffset[coord], 2) .. suffix)
  row[3].handlers.onEditBoxActivated = function()
    C.SetEditBoxText(editbox.id,
      tostring(Helper.round(menu.selectedComponentOffset[coord], 2)))
  end
  row[3].handlers.onTextChanged = function(_, text, textchanged)
    if text ~= "" then menu.selectedComponentOffset[coord] = tonumber(text) end
    C.SetPositionalOffset(menu.selectedcomponent, menu.selectedComponentOffset)
  end
  row[3].handlers.onEditBoxDeactivated = function()
    C.SetEditBoxText(editbox.id,
      Helper.round(menu.selectedComponentOffset[coord], 2) .. suffix)
  end
end

function menu.addClusterOffsetRow(ftable, name, coord)
  local row = ftable:addRow(true, {})
  row[1]:setColSpan(2):createText(name .. ":")
  local editbox = row[3]:createEditBox({ height = Helper.standardTextHeight }):setText(Helper.round(menu
    .selectedComponentClusterGridOffset[coord]))
  row[3].handlers.onTextChanged = menu.editboxClusterCoord
end

function menu.editboxClusterCoord(_, text, coord)
  if text ~= "" then
    menu.selectedComponentClusterGridOffset[coord] = tonumber(text)
  end
  local offset = ffi.new("UIPosRot")
  offset.x, offset.z = menu.convertClusterGridToCoord(menu.selectedComponentClusterGridOffset.q,
    menu.selectedComponentClusterGridOffset.r)
  C.SetPositionalOffset(menu.selectedComponentCluster, offset)
end

function menu.addNameRows(ftable, component)
  local luacomponent = ConvertStringToLuaID(tostring(component))
  local name, rawname, description, rawdescription = GetComponentData(luacomponent, "name", "rawname", "description",
    "rawdescription")

  local row = ftable:addRow(nil, {})
  row[1]:createText("Name:") -- TEMPTEXT Florian
  row[2]:setColSpan(2):createText(name)

  local row = ftable:addRow(true, {})
  row[2]:setColSpan(2):createEditBox({ height = Helper.standardTextHeight }):setText(rawname)
  row[2].handlers.onEditBoxDeactivated = function(_, text, textchanged)
    SetComponentName(luacomponent, text); menu.refreshInfoFrame()
  end

  ftable:addEmptyRow()

  local row = ftable:addRow(nil, {})
  row[1]:createText("Description:") -- TEMPTEXT Florian
  row[2]:setColSpan(2):createText(description)

  local row = ftable:addRow(true, {})
  row[2]:setColSpan(2):createEditBox({ height = Helper.standardTextHeight }):setText(rawdescription)
  row[2].handlers.onEditBoxDeactivated = function(_, text, textchanged)
    C.SetComponentDescription(component, text); menu.refreshInfoFrame()
  end

  ftable:addEmptyRow()
end

function menu.createExportTable(frame)
  local width = 500

  local numcols = 3
  local ftable = frame:addTable(numcols,
    { tabOrder = 3, width = width, x = Helper.viewWidth - width - Helper.frameBorder, y = Helper.frameBorder })

  local row = ftable:addRow(nil, { fixed = true })
  row[1]:setColSpan(numcols):createText("Add Cluster", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

  local row = ftable:addRow(true, { fixed = true })
  row[1]:setColSpan(numcols):createText("Ctrl+RMB into the void to add a cluster at that position.", { wordwrap = true }) -- TEMPTEXT Florian

  ftable:addEmptyRow()

  local row = ftable:addRow(nil, { fixed = true })
  row[1]:setColSpan(numcols):createText("Export Map", Helper.headerRowCenteredProperties) -- TEMPTEXT Florian

  local ismaster = C.IsMasterVersion()
  local ischeat = IsCheatVersion()
  local extensionoptions = {}

  if not ismaster then
    table.insert(extensionoptions, { id = "basegame", text = "Base Game", icon = "", displayremoveoption = false }) -- TEMPTEXT Florian
  end

  local isSelectedExtensionPersonal = false
  local extensions = GetExtensionList()
  for _, extension in ipairs(extensions) do
    if extension.enabled and ((not ismaster) or (not extension.egosoftextension)) and (ischeat or extension.personal) then
      if menu.exportExtension == "" then
        menu.exportExtension = extension.id
      end
      table.insert(extensionoptions,
        { id = extension.id, text = extension.name .. (extension.personal and " (Personal)" or ""), icon = "", displayremoveoption = false }) -- TEMPTEXT Florian
    end
    if menu.exportExtension == extension.id then
      isSelectedExtensionPersonal = extension.personal
    end
  end

  if #extensionoptions > 1 then
    local row = ftable:addRow(true, { fixed = true })
    row[1]:createText("Extension:") -- TEMPTEXT Florian
    row[2]:setColSpan(2):createDropDown(extensionoptions,
      { height = Helper.standardTextHeight, startOption = menu.exportExtension }):setTextProperties({
      fontsize = config
          .mapFontSize
    })
    row[2].handlers.onDropDownConfirmed = function(_, id)
      menu.exportExtension = id; menu.refreshInfoFrame()
    end
  end

  local row = ftable:addRow(true, { fixed = true })
  if isSelectedExtensionPersonal then
    row[1]:setColSpan(numcols):createText(
      "The map will be saved as '*_galaxy_macro.xml' in '$extensionfolder/maps' sub-folder of your personal X4 folder.\n\nThis file will contain all cluster, sector and zone macros of this map, each starting with the prefix '*_'.\n\nMake sure to add a macro index entry in the $extensionfolder to reference the exported map, e.g. '<entry name=\"extensionmap_*\" value=\"maps\\extensionmap_*\" />'",
      { wordwrap = true }) -- TEMPTEXT Florian
  else
    if menu.exportExtension == "basegame" then
      row[1]:setColSpan(numcols):createText(
        "The map will be saved as 'basegame_map_*_galaxy_macro.xml' in 'maps'.\n\nThis file will contain all cluster, sector and zone macros of this map, each starting with the prefix 'basegame_map_*_'.",
        { wordwrap = true }) -- TEMPTEXT Florian
    else
      row[1]:setColSpan(numcols):createText(
        "The map will be saved as '*_galaxy_macro.xml' in '$extensionfolder/maps'.\n\nThis file will contain all cluster, sector and zone macros of this map, each starting with the prefix '*_'.\n\nMake sure to add a macro index entry in the $extensionfolder to reference the exported map, e.g. '<entry name=\"extensionmap_*\" value=\"maps\\extensionmap_*\" />'",
        { wordwrap = true }) -- TEMPTEXT Florian
    end
  end

  local row = ftable:addRow(true, { fixed = true })
  row[1]:setColSpan(numcols):createEditBox({ height = Helper.standardTextHeight, defaultText = "Enter map name here" })
      :setText(menu.mapname) -- TEMPTEXT Florian
  row[1].handlers.onTextChanged = function(_, text, textchanged) menu.mapname = text end

  local row = ftable:addRow(true, { fixed = true })
  row[3]:createButton({ active = function() return (menu.mapname ~= "") and (menu.exportExtension ~= "") end }):setText(
    "Export", { halign = "center" }) -- TEMPTEXT Florian
  row[3].handlers.onClick = function()
    local filename = string.gsub(menu.mapname, "[^%w_%-%() ]", "_"); return C.ExportMap(filename,
      (menu.exportExtension ~= "basegame") and menu.exportExtension or "", isSelectedExtensionPersonal)
  end

  ftable.properties.y = Helper.viewHeight - ftable:getFullHeight() - ftable.properties.y
end

function menu.createInfoFrame2()
  menu.createInfoFrame2Running = true
  -- remove old data
  Helper.removeAllWidgetScripts(menu, config.infoFrame2Layer)

  menu.infoFrame2 = Helper.createFrameHandle(menu, {
    layer = config.infoFrame2Layer,
    standardButtons = {},
    width = Helper.viewWidth,
    height = Helper.viewHeight,
    x = 0,
    y = 0,
  })

  if menu.showMacroSuggestions then
    menu.createMacroSearchTable(menu.infoFrame2)
  end

  menu.infoFrame2:display()
end

function menu.refreshInfoFrame2()
  if not menu.createInfoFrame2Running then
    menu.createInfoFrame2()
  end
end

function menu.createMacroSearchTable(frame)
  local width = 500
  local numcols = 3

  local ftable = frame:addTable(numcols,
    {
      tabOrder = 11,
      width = width,
      x = Helper.frameBorder + menu.sideBarWidth + 2 * Helper.borderSize + width +
          Helper.borderSize,
      y = Helper.frameBorder
    })

  local row = ftable:addRow(nil, { fixed = true })
  row[1]:setColSpan(numcols):createText("Suggested macros:", Helper.subHeaderTextProperties) -- TEMPTEXT Florian

  if menu.macrosearch ~= "" then
    local n = C.GetNumMacrosStartingWith(menu.macrosearch)
    if n > 0 then
      local buf = ffi.new("const char*[?]", n)
      n = C.GetMacrosStartingWith(buf, n, menu.macrosearch)
      for i = 0, n - 1 do
        local macro = ffi.string(buf[i])

        local row = ftable:addRow(true, {})
        row[1]:setColSpan(numcols):createButton({}):setText((GetMacroData(macro, "name") or "") .. " (" .. macro .. ")")
        row[1].handlers.onClick = function()
          menu.macrosearch = macro; menu.showMacroSuggestions = false; menu.refreshInfoFrame(); menu.refreshInfoFrame2()
        end
      end
    end
  end
end

function menu.closeContextMenu(dueToClose)
  if Helper.closeInteractMenu() then
    return true
  end
  if menu.contextMenuMode then
    -- REMOVE this block once the mouse out/over event order is correct -> This should be unnessecary due to the global tablemouseout event reseting the picking
    if menu.currentMouseOverTable and (
          (menu.contextMenuMode == "boardingcontext")
          or (menu.contextMenuMode == "dropwares")
        ) then
      menu.picking = true
      menu.currentMouseOverTable = nil
    end
    -- END
    menu.contextFrame = nil
    Helper.clearFrame(menu, config.contextFrameLayer)
    menu.contextMenuData = {}
    menu.contextMenuMode = nil
    return true
  end
  return false
end

-- update
menu.updateInterval = 0.01
function menu.onUpdate()
  local curtime = getElapsedTime()
  if menu.mainFrame then
    menu.mainFrame:update()
  end
  if menu.infoFrame then
    menu.infoFrame:update()
  end
  if menu.infoFrame2 then
    menu.infoFrame2:update()
  end

  if menu.map and menu.holomap ~= 0 then
    local x, y = GetRenderTargetMousePosition(menu.map)
    C.SetMapRelativeMousePosition(menu.holomap, (x and y) ~= nil, x or 0, y or 0)
  end

  if menu.activatemap then
    -- pass relative screenspace of the holomap rendertarget to the holomap (value range = -1 .. 1)
    local renderX0, renderX1, renderY0, renderY1 = Helper.getRelativeRenderTargetSize(menu, config.mainFrameLayer,
      menu.map)
    local rendertargetTexture = GetRenderTargetTexture(menu.map)
    if rendertargetTexture then
      local mapstate
      if menu.holomap ~= 0 then
        mapstate = ffi.new("HoloMapState")
        C.GetMapState(menu.holomap, mapstate)
      end

      menu.holomap = C.AddHoloMap(rendertargetTexture, renderX0, renderX1, renderY0, renderY1,
        menu.rendertargetWidth / menu.rendertargetHeight, 1)
      if menu.holomap ~= 0 then
        C.ClearSelectedMapComponents(menu.holomap)
        C.ShowEditorMap(menu.holomap, C.GetContextByClass(C.GetPlayerID(), "sector", false))

        if mapstate then
          C.SetMapState(menu.holomap, mapstate)
        end
      end

      menu.activatemap = false
    end
  end

  if not menu.refreshed then
    if menu.holomap and (menu.holomap ~= 0) then
      if menu.picking ~= menu.pickstate then
        menu.pickstate = menu.picking
        C.SetMapPicking(menu.holomap, menu.pickstate)
      end
    end
  end
  menu.refreshed = nil

  if menu.panningmap and menu.panningmap.isclick then
    local offset = table.pack(GetLocalMousePosition())
    if (menu.leftdown.time + 0.5 < curtime) or Helper.comparePositions(menu.leftdown.position, offset, 5) then
      menu.panningmap.isclick = false
    end
  end

  if menu.leftdown then
    if not menu.leftdown.wasmoved then
      local offset = table.pack(GetLocalMousePosition())
      if Helper.comparePositions(menu.leftdown.position, offset, 5) then
        menu.leftdown.wasmoved = true
      end
    end
    if menu.leftdown.wasmoved and menu.leftdown.time + 0.1 < curtime and not C.IsComponentClass(C.GetPickedMapComponent(menu.holomap), "object") then
      local currentmousepos = table.pack(GetLocalMousePosition())
      if menu.panningmap then
        menu.leftdown.dynpos = currentmousepos
      end
    end
  end

  if menu.rightdown then
    if not menu.rightdown.wasmoved then
      local offset = table.pack(GetLocalMousePosition())
      if Helper.comparePositions(menu.rightdown.position, offset, 5) then
        menu.rightdown.wasmoved = true
      end
    end
    if menu.rightdown.wasmoved and menu.rightdown.time + 0.1 < curtime and not C.IsComponentClass(C.GetPickedMapComponent(menu.holomap), "object") then
      local currentmousepos = table.pack(GetLocalMousePosition())
      if menu.rotatingmap then
        menu.rightdown.dynpos = currentmousepos
      end
    end
  end

  if menu.refreshIF and (menu.refreshIF < curtime) then
    menu.refreshInfoFrame()
    menu.refreshIF = nil
  end
  if menu.refreshIF2 and (menu.refreshIF2 < curtime) then
    menu.refreshInfoFrame2()
    menu.refreshIF2 = nil
  end

  if menu.revealmap and (menu.revealmap < curtime) then
    C.RevealMap()
  end
end

function menu.viewCreated(layer, ...)
  if layer == config.mainFrameLayer then
    menu.map, menu.sideBar = ...

    if menu.activatemap == nil then
      menu.activatemap = true
    end

    menu.createMainFrameRunning = false
  elseif layer == config.infoFrameLayer then
    menu.createInfoFrameRunning = false
  elseif layer == config.infoFrame2Layer then
    menu.createInfoFrame2Running = false
  end
end

-- close menu handler
function menu.onCloseElement(dueToClose, layer)
  if (layer == nil) or (layer == config.mainFrameLayer) or (layer == config.infoFrameLayer) or (layer == config.infoFrame2Layer) then
    Helper.closeMenu(menu, dueToClose)
    menu.cleanup()
  elseif layer == config.contextFrameLayer then
    Helper.clearFrame(menu, layer)
  end
end

-- table mouse input helper
function menu.onTableMouseOut(uitable, row)
  if menu.currentMouseOverTable and (uitable == menu.currentMouseOverTable) then
    menu.currentMouseOverTable = nil
    if menu.holomap ~= 0 then
      menu.picking = true
    end
  end
end

function menu.onTableMouseOver(uitable, row)
  menu.currentMouseOverTable = uitable
  if menu.holomap ~= 0 then
    menu.picking = false
  end
end

-- rendertarget selections
function menu.onRenderTargetSelect(modified)
  local offset = table.pack(GetLocalMousePosition())
  -- Check if the mouse button was down less than 0.5 seconds and the mouse was moved more than a distance of 5px
  if (not menu.leftdown) or ((menu.leftdown.time + 0.5 > getElapsedTime()) and not Helper.comparePositions(menu.leftdown.position, offset, 5)) then
    local newselectedcomponent = 0

    local pickedcomponent = C.GetPickedMapComponent(menu.holomap)
    local pickedcomponentclass = ffi.string(C.GetComponentClass(pickedcomponent))
    if pickedcomponent ~= 0 then
      newselectedcomponent = pickedcomponent
    end

    if newselectedcomponent ~= menu.selectedcomponent then
      menu.selectedcomponent = newselectedcomponent
      if menu.selectedcomponent ~= 0 then
        if C.IsComponentClass(menu.selectedcomponent, "object") then
          menu.macrosearch = GetComponentData(ConvertStringToLuaID(tostring(menu.selectedcomponent)), "macro")
        end
        C.SetSelectedMapComponent(menu.holomap, newselectedcomponent)

        if menu.gateconnection and menu.gateconnection ~= menu.selectedcomponent then
          if C.IsComponentClass(menu.selectedcomponent, "gate") then
            C.AddGateConnection(menu.gateconnection, menu.selectedcomponent)
            menu.gateconnection = nil
          end
        end
      else
        C.ClearSelectedMapComponents(menu.holomap)
      end
      menu.refreshInfoFrame()
    end
  end
  menu.leftdown = nil
end

-- rendertarget doubleclick
function menu.onRenderTargetDoubleClick(modified)
  local pickedcomponent = C.GetPickedMapComponent(menu.holomap)
  if pickedcomponent ~= 0 then
    if C.IsComponentClass(pickedcomponent, "sector") then

    end
  end
end

-- rendertarget mouse input helper
function menu.onRenderTargetMouseDown(modified)
  menu.leftdown = {
    time = getElapsedTime(),
    position = table.pack(GetLocalMousePosition()),
    dynpos = table.pack(
      GetLocalMousePosition())
  }

  if modified == "shift" then
    C.StartMapBoxSelect(menu.holomap, false)
  else
    C.StartPanMap(menu.holomap)
    menu.panningmap = { isclick = true }
    menu.noupdate = true
  end
end

function menu.onRenderTargetMouseUp(modified)
  if menu.panningmap then
    C.StopPanMap(menu.holomap)
    menu.noupdate = false
    menu.panningmap = nil
    menu.refreshInfoFrame()
  else
    C.StopMapBoxSelect(menu.holomap)
    local components = {}
    Helper.ffiVLA(components, "UniverseID", C.GetNumMapSelectedComponents, C.GetMapSelectedComponents, menu.holomap)

    if #components > 0 then

    end
  end
end

function menu.onRenderTargetRightMouseDown()
  menu.closeContextMenu()
  menu.rightdown = {
    time = getElapsedTime(),
    position = table.pack(GetLocalMousePosition()),
    dynpos = table.pack(
      GetLocalMousePosition())
  }

  C.StartRotateMap(menu.holomap)
  menu.rotatingmap = true
  menu.noupdate = true
end

function menu.onRenderTargetRightMouseUp(modified)
  local offset = table.pack(GetLocalMousePosition())

  -- Check if the mouse was moved more than a distance of 5px
  if menu.rightdown and (not Helper.comparePositions(menu.rightdown.position, offset, 5)) and (not menu.rightdown.wasmoved) then
    local pickedcomponent = C.GetPickedMapComponent(menu.holomap)

    local posrot = ffi.new("UIPosRot")
    local eclipticoffset = ffi.new("UIPosRot")
    local posrotcomponent = C.GetMapPositionOnEcliptic2(menu.holomap, posrot, false, 0, eclipticoffset)

    if pickedcomponent ~= 0 then
      local convertedComponent = ConvertStringTo64Bit(tostring(pickedcomponent))
      if modified ~= "ctrl" then
        local missions = {}
        Helper.ffiVLA(missions, "MissionID", C.GetNumMapComponentMissions, C.GetMapComponentMissions, menu.holomap,
          pickedcomponent)

        local playerships, otherobjects, playerdeployables = {}, {}, {}
        Helper.openInteractMenu(menu,
          {
            component = pickedcomponent,
            offsetcomponent = posrotcomponent,
            offset = posrot,
            playerships = playerships,
            otherobjects =
                otherobjects,
            playerdeployables = playerdeployables,
            componentmissions = missions
          })
      else
        if menu.spawnTableMode == "object" then
          if C.FindMacro(menu.macrosearch) then
            if IsMacroClass(menu.macrosearch, "object") then
              local object = C.SpawnObjectAtPos2(menu.macrosearch, posrotcomponent, posrot, "player")
              if object ~= 0 then
                C.SetObjectForcedRadarVisible(object, true)
              end
            end
          end
        elseif menu.spawnTableMode == "region" then
          if menu.regiondefinition ~= "" then
            C.SpawnRegionAtPos(menu.regiondefinition, posrotcomponent, posrot)
          end
        elseif menu.spawnTableMode == "station" then
          if menu.constructionplan ~= "" then
            local station = C.SpawnStationAtPos("station_gen_factory_base_01_macro", posrotcomponent, posrot,
              menu.constructionplan, menu.cpfaction)
            if station ~= 0 then
              C.SetObjectForcedRadarVisible(station, true)
              C.SetKnownTo(station, "player")
            end
          end
        elseif menu.spawnTableMode == "highway" then
          C.SpawnLocalHighwayAtPos("editor_local_highway_macro", posrotcomponent, posrot)
        end
      end
    else
      if modified == "ctrl" then
        local offset = ffi.new("UIPosRot")
        -- Why is there a factor of 25???
        offset.x = posrot.x * 25
        offset.y = posrot.y * 25
        offset.z = posrot.z * 25
        -- snap to the hex grid
        local q, r = menu.snapToClusterGrid(offset)
        offset.x, offset.z = menu.convertClusterGridToCoord(q, r)
        C.AddCluster("editor_cluster_001_macro", offset)
        menu.activatemap = true
        menu.revealmap = getElapsedTime()
      end
    end
  end
  menu.rightdown = nil
  if menu.rotatingmap then
    C.StopRotateMap(menu.holomap)
    menu.noupdate = false
    if menu.sound_rotatemap and menu.sound_rotatemap.sound then
      StopPlayingSound(menu.sound_rotatemap.sound)
      menu.sound_rotatemap = nil
    end
    menu.rotatingmap = nil
    if menu.infoTableMode == "objectlist" then
      menu.refreshInfoFrame()
    end
  end
end

function menu.snapToClusterGrid(offset)
  local l = config.clusterGridEdgeLength

  -- convert to hex coordinates with r == y axis and q axis being 60° ccw from x axis
  local q = (2 * offset.x) / (3 * l)
  local r = (-offset.x + math.sqrt(3) * offset.z) / (3 * l)
  local s = -q - r

  -- snap to grid
  local roundQ = Helper.round(q)
  local roundR = Helper.round(r)
  local roundS = Helper.round(s)

  local q_diff = math.abs(roundQ - q)
  local r_diff = math.abs(roundR - r)
  local s_diff = math.abs(roundS - s)

  if q_diff > r_diff and q_diff > s_diff then
    roundQ = -roundR - roundS
  elseif r_diff > s_diff then
    roundR = -roundQ - roundS
  end

  -- Adjust to holomap hex display ( q axis == zig-zag x-axis)
  roundR = roundR + math.floor(roundQ / 2)

  return roundQ, roundR
end

function menu.convertClusterGridToCoord(q, r)
  local l = config.clusterGridEdgeLength

  local x = 3 * l * q / 2
  local y = math.sqrt(3) * l * (r + q / 2 - math.floor(Helper.round(q) / 2))

  return x, y
end

function menu.onRenderTargetCombinedScrollDown(step)
  C.ZoomMap(menu.holomap, step)
end

function menu.onRenderTargetCombinedScrollUp(step)
  C.ZoomMap(menu.holomap, -step)
end

function menu.buttonToggleSpawnTable(spawntableparam)
  local oldidx, newidx
  local leftbar = config.leftBar
  local count = 1
  for _, entry in ipairs(leftbar) do
    if (entry.condition == nil) or entry.condition() then
      if entry.mode then
        if type(entry.mode) == "table" then
          for _, mode in ipairs(entry) do
            if mode == menu.spawnTableMode then
              oldidx = count
            end
            if mode == spawntableparam then
              newidx = count
            end
          end
        else
          if entry.mode == menu.spawnTableMode then
            oldidx = count
          end
          if entry.mode == spawntableparam then
            newidx = count
          end
        end
      end
      count = count + 1
    end
    if oldidx and newidx then
      break
    end
  end

  local deactivate = menu.spawnTableMode == spawntableparam

  if newidx then
    Helper.updateButtonColor(menu.sideBar, newidx, 1, Color["row_background_blue"])
  end
  if oldidx then
    Helper.updateButtonColor(menu.sideBar, oldidx, 1, Color["button_background_default"])
  end

  AddUITriggeredEvent(menu.name, spawntableparam, menu.spawnTableMode == spawntableparam and "off" or "on")
  if deactivate then
    PlaySound("ui_negative_back")
    menu.spawnTableMode = nil
  else
    PlaySound("ui_positive_select")
    menu.spawnTableMode = spawntableparam
  end

  menu.refreshMainFrame()
  menu.refreshInfoFrame()

  menu.showMacroSuggestions = false;
  menu.refreshInfoFrame2()
end

init()
