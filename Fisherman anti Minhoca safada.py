import os
from datetime import datetime

# ============================================
# ANTIVÍRUS EDUCATIVO - fisherman 
# ============================================
# esse arquivo funciona como um antivírus inteligente, ele identifica características únicas do malware e define se é 
# o arquivo da minhoca safada, imitando o comportamento de um scan
# ============================================

# Pastas onde a minhoca safada pode estar
folders = [
    os.getenv('TEMP'),
    os.path.join(os.getenv('LOCALAPPDATA'), 'Temp'),
    os.path.join(os.getenv('APPDATA'), 'Cache'),
    os.path.join(os.getenv('APPDATA'), 'Microsoft', 'Windows', 'Start Menu', 'Programs', 'Startup')
]

# Características únicas da Minhoca Safada
signatures = [
    "VersaoA", "VersaoB", "VersaoC", "VersaoD", "VersaoE",
    "Log-Coco", "Escolhe-Frase", "frases = @(",
    "Copy-Item $scriptSource", "Add-Content -Path $logFile",
    "Write-Host \"Minhoca"
]

# Pasta de logs na Downloads
downloads_dir = os.path.join(os.getenv('USERPROFILE'), 'Downloads')
log_dir = os.path.join(downloads_dir, 'O Exterminador de Minhocas')
os.makedirs(log_dir, exist_ok=True)

def detect_and_remove(file_path):
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            for line in f:
                if any(sig in line for sig in signatures):
                    os.remove(file_path)
                    log_msg = f"{datetime.now()} - Eu limpei a bosta que a minhoca tinha cagado: {file_path}"
                    log_file = os.path.join(log_dir, f"log_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt")
                    with open(log_file, "w", encoding="utf-8") as lf:
                        lf.write(log_msg + "\n")
                    print(f"[REMOVIDO] {file_path}")
                    print(f"[LOG CRIADO] {log_file}")
                    return  # Para assim que detecta
    except Exception as e:
        print(f"Erro ao processar {file_path}: {e}")

# Varredura completa
for folder in folders:
    if folder and os.path.exists(folder):
        for root, dirs, files in os.walk(folder):
            for name in files:
                if name.endswith(".ps1"):
                    detect_and_remove(os.path.join(root, name))

print("Varredura completa! A Minhoca Safada foi expulsa 💀💩")
print(f"Logs disponíveis em: {log_dir}")
print("feito pelo Marcelo💀🙏")
