#Requires -RunAsAdministrator
<#
    ShopLaptop - Script cai dat tu dong
    Chay script nay de cau hinh database va khoi dong website tren may moi

    Cu phap: .\setup.ps1 [-SqlServer <ten_server>] [-ResetPassword]
#>

param(
    [string]$SqlServer = "localhost\SQLEXPRESS01",
    [switch]$ResetPassword,
    [string]$NewPassword = "Admin@123"
)

# ---------- Mau sac ----------
$OK = @{ foregroundColor = "Green" }
$WARN = @{ foregroundColor = "Yellow" }
$ERROR = @{ foregroundColor = "Red" }
$INFO = @{ foregroundColor = "Cyan" }

function Write-Step { param($msg) Write-Host "`n>>> $msg" @INFO }
function Write-Success { param($msg) Write-Host "[OK] $msg" @OK }
function Write-Warn { param($msg) Write-Host "[WARN] $msg" @WARN }
function Write-Err { param($msg) Write-Host "[ERROR] $msg" @ERROR }
function Write-Info { param($msg) Write-Host "[INFO] $msg" }

# ---------- Lay duong dan ----------
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent $ScriptDir
$SrcDir = Join-Path $RootDir "src\Shop"
$WebConfig = Join-Path $SrcDir "Web.config"
$SqlScript = Join-Path $ScriptDir "scriptlaptop.sql"
$AppHostConfig = Join-Path $RootDir "src\.vs\Shop\config\applicationhost.config"

# ---------- Kiem tra duong dan ----------
Write-Step "Kiem tra du lieu..."

if (-not (Test-Path $WebConfig)) {
    Write-Err "Khong tim thay Web.config tai: $WebConfig"
    exit 1
}
if (-not (Test-Path $SqlScript)) {
    Write-Err "Khong tim thay script SQL tai: $SqlScript"
    exit 1
}
Write-Success "Cac file can thiet da tim thay."

# ---------- Kiem tra SQL Server ----------
Write-Step "Kiem tra SQL Server: $SqlServer"

$TestConn = "
    Server=$SqlServer;
    Database=master;
    Integrated Security=True;
    Connect Timeout=5
"
try {
    $conn = New-Object System.Data.SqlClient.SqlConnection $TestConn
    $conn.Open()
    $conn.Close()
    Write-Success "Ket noi SQL Server thanh cong."
} catch {
    Write-Err "Khong the ket noi SQL Server '$SqlServer'. Vui long kiem tra ten server."
    Write-Info "  - Mo SSMS va kiem tra ten server (thuong la 'localhost\SQLEXPRESS01' hoac '.\SQLEXPRESS')"
    Write-Info "  - Hoac chay voi tham so: .\setup.ps1 -SqlServer '<ten_cua_ban>'"
    exit 1
}

# ---------- Kiem tra database ----------
Write-Step "Kiem tra database ShopLaptop..."

$DbConn = "
    Server=$SqlServer;
    Database=master;
    Integrated Security=True;
"
$checkDb = Invoke-SqlCmd -ServerInstance $SqlServer -Query "
    SELECT name FROM sys.databases WHERE name = 'ShopLaptop'
" -ErrorAction SilentlyContinue

if ($checkDb) {
    Write-Warn "Database 'ShopLaptop' da ton tai."
    if ($ResetPassword) {
        Write-Info "Reset password admin..."
    } else {
        $continue = Read-Host "Ban co muon xoa va tao lai database? (y/N)"
        if ($continue -ne "y") {
            Write-Info "Bo qua buoc tao database."
        } else {
            Write-Step "Xoa database cu..."
            Invoke-SqlCmd -ServerInstance $SqlServer -Query "
                ALTER DATABASE [ShopLaptop] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                DROP DATABASE [ShopLaptop];
            " -ErrorAction Stop
            $checkDb = $null
        }
    }
}

# ---------- Tao database ----------
if (-not $checkDb) {
    Write-Step "Tao database ShopLaptop..."

    # Doc script SQL
    $content = Get-Content $SqlScript -Raw -Encoding Unicode

    # Lay duong dan data cua SQL Server
    $dataPath = Invoke-SqlCmd -ServerInstance $SqlServer -Query "
        SELECT TOP 1 LEFT(physical_name, LEN(physical_name) - CHARINDEX('\', REVERSE(physical_name)) + 1)
        FROM sys.master_files
        WHERE database_id = DB_ID('master')
    " | Select-Object -First 1 | ForEach-Object { $_."".TrimEnd() }

    if (-not $dataPath) {
        $dataPath = "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA"
        Write-Warn "Khong doc duoc duong dan data, su dung mac dinh: $dataPath"
    }

    Write-Info "Duong dan data SQL: $dataPath"

    # Thay duong dan file trong script
    $content = $content -replace 'C:\\Program Files\\Microsoft SQL Server\\MSSQL16\.MSSQLSERVER\\MSSQL\\DATA\\', ($dataPath -replace '\\', '\\')

    # Chuan bi script: tao database truoc roi chay phan con lai
    $lines = $content -split "`r?`n"
    $createDbLine = -1
    $useDbLine = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match 'CREATE DATABASE \[ShopLaptop\]') { $createDbLine = $i }
        if ($lines[$i] -match 'USE \[ShopLaptop\]') { $useDbLine = $i; break }
    }

    if ($createDbLine -ge 0 -and $useDbLine -gt $createDbLine) {
        # Tach script thanh 2 phan: tao DB va tao bang
        $createDbLines = $lines[0..($useDbLine - 1)] -join "`n"
        $createTablesLines = $lines[$useDbLine..($lines.Count - 1)] -join "`n"

        # Chay tao database
        Write-Info "Tao database..."
        Invoke-SqlCmd -ServerInstance $SqlServer -Query $createDbLines -ErrorAction Stop
        Write-Success "Database tao thanh cong."

        # Chay tao bang va du lieu
        Write-Info "Tao bang va du lieu (co the mat 1-2 phut)..."
        Invoke-SqlCmd -ServerInstance $SqlServer -Database "ShopLaptop" -Query $createTablesLines -ErrorAction Stop
        Write-Success "Tao bang va du lieu thanh cong."
    } else {
        Write-Err "Khong tim thay cu phap CREATE DATABASE trong script SQL."
        exit 1
    }
}

# ---------- Cap nhat Web.config ----------
Write-Step "Cap nhat Web.config..."

$configContent = Get-Content $WebConfig -Raw

$newContent = $configContent `
    -replace 'Data Source=[^;]+', "Data Source=$SqlServer" `
    -replace 'data source=[^;]+', "data source=$SqlServer"

if ($configContent -eq $newContent) {
    Write-Warn "Web.config chua thay doi (co the da duoc cau hinh)."
} else {
    Set-Content -Path $WebConfig -Value $newContent -NoNewline
    Write-Success "Da cap nhat Web.config voi server: $SqlServer"
}

# ---------- Cap nhat applicationhost.config ----------
Write-Step "Cap nhat applicationhost.config (IIS Express)..."

if (Test-Path $AppHostConfig) {
    $hostContent = Get-Content $AppHostConfig -Raw
    if ($hostContent -match 'physicalPath="([^"]*)"') {
        $oldPath = $matches[1]
        $newPath = $SrcDir
        $hostContent = $hostContent -replace [regex]::Escape($oldPath), $newPath
        Set-Content -Path $AppHostConfig -Value $hostContent -NoNewline
        Write-Success "Da cap nhat physicalPath: $newPath"
    }
} else {
    Write-Warn "Khong tim thay applicationhost.config. Bo qua buoc nay."
}

# ---------- Reset password admin ----------
if ($ResetPassword) {
    Write-Step "Reset password admin..."

    $hashExe = Join-Path $ScriptDir "HashPass.exe"
    if (Test-Path $hashExe) {
        & $hashExe $NewPassword $SqlServer | ForEach-Object {
            if ($_ -match '^\[OK\]') { Write-Host $_ @OK }
            elseif ($_ -match '^\[ERROR\]') { Write-Host $_ @ERROR }
            elseif ($_ -match '^\[WARN\]') { Write-Host $_ @WARN }
            else { Write-Host $_ }
        }
    } else {
        Write-Warn "Khong tim thay HashPass.exe. Bo qua reset password."
    }
}

# ---------- Kiem tra duong dan IIS Express ----------
Write-Step "Kiem tra IIS Express..."

$iisExpress = "${env:ProgramFiles}\IIS Express\iisexpress.exe"
if (-not (Test-Path $iisExpress)) {
    $iisExpress = "${env:ProgramFiles(x86)}\IIS Express\iisexpress.exe"
}

if (Test-Path $iisExpress) {
    Write-Success "IIS Express tim thay tai: $iisExpress"
} else {
    Write-Warn "IIS Express khong tim thay. Ban co the phai mo project bang Visual Studio de chay."
}

# ---------- Hoan tat ----------
Write-Host ""
Write-Host "========================================" @OK
Write-Host "   Cai dat hoan tat!" @OK
Write-Host "========================================" @OK
Write-Host ""
Write-Host "  Database : ShopLaptop" -ForegroundColor White
Write-Host "  SQL Server: $SqlServer" -ForegroundColor White
Write-Host "  Du an    : $SrcDir" -ForegroundColor White
Write-Host ""
Write-Host "  Tai khoan Admin:" -ForegroundColor Yellow
Write-Host "    Email    : admin1@admin.com" -ForegroundColor White
Write-Host "    Password : $($ResetPassword ? $NewPassword : 'Admin@123')" -ForegroundColor White
Write-Host ""
Write-Host "  Cach 1 - Chay bang Visual Studio:" -ForegroundColor Cyan
Write-Host "    1. Mo file: src\Shop\Shop.csproj" -ForegroundColor Gray
Write-Host "    2. Nhan F5 de khoi dong" -ForegroundColor Gray
Write-Host ""
Write-Host "  Cach 2 - Chay bang IIS Express (da cai san):" -ForegroundColor Cyan
Write-Host '    & "C:\Program Files\IIS Express\iisexpress.exe" /config:"'"$AppHostConfig"'" /site:"Shop"' -ForegroundColor Gray
Write-Host ""
