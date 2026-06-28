@echo off
title ShopLaptop - Cau Hinh Database
color 0B

echo.
echo  ========================================
echo   ShopLaptop - Cau Hinh Tu Dong
echo  ========================================
echo.

:: Kiem tra quyen admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [WARN] Script can chay voi quyen Administrator.
    echo        Right-click ^> Run as administrator
    echo.
    pause
    exit /b 1
)

:: Hoi ten server SQL
echo Nhap ten SQL Server:
echo   - Neu dung SQL Express: localhost\SQLEXPRESS01
echo   - Neu dung LocalDB: (localdb)\MSSQLLocalDB
echo   - Hoac nhap ten may: TENMAY\SQLEXPRESS01
echo.
set /p SQLSERVER="SQL Server (mac dinh: localhost\SQLEXPRESS01): "
if "%SQLSERVER%"=="" set SQLSERVER=localhost\SQLEXPRESS01

echo.
echo Dang kiem tra SQL Server: %SQLSERVER% ...

:: Kiem tra sqlcmd
where sqlcmd >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Khong tim thay sqlcmd. Vui long cai SQL Server Management Studio.
    echo.
    pause
    exit /b 1
)

:: Kiem tra ket noi SQL
sqlcmd -S "%SQLSERVER%" -E -Q "SELECT @@VERSION" -b >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Khong ket noi duoc SQL Server '%SQLSERVER%'.
    echo         Kiem tra ten server trong SSMS.
    echo.
    pause
    exit /b 1
)
echo [OK] Ket noi SQL Server thanh cong.

:: Lay duong dan data cua SQL Server
echo Dang doc duong dan data SQL Server...

for /f "tokens=2 delims=:" %%a in ('sqlcmd -S "%SQLSERVER%" -E -h -1 -Q "SET NOCOUNT ON; SELECT TOP 1 physical_name FROM sys.master_files WHERE database_id = DB_ID('master')" 2^>nul') do (
    for %%b in (%%a) do set "DATAPATH=%%~dpb"
)
set "DATAPATH=%DATAPATH:~0,-1%"

if "%DATAPATH%"=="" (
    set "DATAPATH=C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA"
    echo [WARN] Khong doc duoc duong dan, su dung mac dinh.
) else (
    echo [OK] Duong dan data: %DATAPATH%
)

:: Doc script SQL
set "SCRIPTDIR=%~dp0"
set "SQLFILE=%SCRIPTDIR%scriptlaptop.sql"
if not exist "%SQLFILE%" (
    echo [ERROR] Khong tim thay scriptlaptop.sql tai: %SQLFILE%
    pause
    exit /b 1
)

:: Hoi tao lai database
echo.
set /p RECREATE="Database 'ShopLaptop' se duoc tao. Tiep tuc? (Y/N): "
if /i "%RECREATE%" neq "Y" (
    echo Huy cau hinh.
    exit /b 0
)

:: Tao database
echo.
echo Dang tao database...

sqlcmd -S "%SQLSERVER%" -E -b -i "%SQLFILE%" -v DATAPATH="%DATAPATH%" >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [WARN] Script co loi. Thu tao database thu cong...

    sqlcmd -S "%SQLSERVER%" -E -b -Q "CREATE DATABASE [ShopLaptop]" >nul 2>&1
    if %errorLevel% neq 0 (
        echo [ERROR] Khong tao duoc database.
        pause
        exit /b 1
    )

    echo [OK] Database tao thanh cong.

    :: Chay script tao bang (bo qua CREATE DATABASE)
    echo Dang tao bang va du lieu...
    powershell -Command "Get-Content '%SQLFILE%' -Encoding Unicode | Select-Object -Skip 1 | Set-Content '%TEMP%\script_tables.sql' -Encoding UTF8"
    sqlcmd -S "%SQLSERVER%" -E -b -d ShopLaptop -i "%TEMP%\script_tables.sql"
    del "%TEMP%\script_tables.sql" 2>nul
)

echo [OK] Database va du lieu da san sang.

:: Cap nhat Web.config
echo.
echo Dang cap nhat Web.config...

set "PROJDIR=%SCRIPTDIR%..\src\Shop"
set "WEBCONFIG=%PROJDIR%\Web.config"

powershell -Command "(Get-Content '%WEBCONFIG%') -replace 'Data Source=[^;]+', 'Data Source=%SQLSERVER%' -replace 'data source=[^;]+', 'data source=%SQLSERVER%' | Set-Content '%WEBCONFIG%'"

if %errorLevel% equ 0 (
    echo [OK] Da cap nhat Web.config voi server: %SQLSERVER%
) else (
    echo [WARN] Khong cap nhat duoc Web.config.
)

:: Cap nhat applicationhost.config
echo.
echo Dang cap nhat IIS Express...

set "APPCONFIG=%SCRIPTDIR%..\src\.vs\Shop\config\applicationhost.config"
if exist "%APPCONFIG%" (
    powershell -Command "(Get-Content '%APPCONFIG%' -Raw) -replace 'physicalPath=[^>]+>', ('physicalPath=\"%PROJDIR%\\\"' -replace '\\', '\\\\') | Set-Content '%APPCONFIG%'"
    echo [OK] Da cap nhat IIS Express config.
) else (
    echo [WARN] Khong tim thay applicationhost.config.
)

:: Reset password
echo.
echo Dang dat lai password admin...

"%SCRIPTDIR%HashPass.exe" "Admin@123" "%SQLSERVER%"
if %errorLevel% neq 0 (
    echo [WARN] Khong dat lai password duoc bang HashPass.exe.
    echo        Thu dong minh reset thu cong.
)

:: Hoan tat
echo.
echo ========================================
echo    Cau hinh thanh cong!
echo ========================================
echo.
echo   Database  : ShopLaptop
echo   SQL Server: %SQLSERVER%
echo.
echo   Tai khoan Admin:
echo     Email    : admin1@admin.com
echo     Password : Admin@123
echo.
echo   De khoi dong website:
echo     1. Mo Visual Studio
echo     2. Mo file: src\Shop\Shop.csproj
echo     3. Nhan F5
echo.
pause
