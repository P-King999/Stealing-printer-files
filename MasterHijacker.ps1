# ===== 路径配置 =====
$WorkDir    = "D:\ProgramDate\appcompat\print"
$WatchPath  = "$env:SystemRoot\System32\Spool\PRINTERS"
$DestFolder = "$WorkDir\Backups"
$GS_Path    = "$WorkDir\gswin64c.exe"
$GPL_Path   = "$WorkDir\gpcl6win64.exe"
$GXPS_Path  = "$WorkDir\gxpswin64.exe"
$LogFile    = "$WorkDir\convert.log"

$ProcessedJobs = @{} 

if (!(Test-Path $DestFolder)) { New-Item $DestFolder -Type Directory -Force | Out-Null }
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Write-Log($msg) {
    $t = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$t $msg" | Out-File $LogFile -Append -Encoding utf8
}

# --- 新增功能：从 SHD 文件提取原始文件名 ---
function Get-OriginalName($ShdPath) {
    try {
        $bytes = [System.IO.File]::ReadAllBytes($ShdPath)
        # 将二进制转为 Unicode 字符串（文件名在 SHD 中通常以 Unicode 存储）
        $rawString = [System.Text.Encoding]::Unicode.GetString($bytes)
        
        # 使用正则匹配常见的文档后缀，提取前方的文件名
        if ($rawString -match '([a-zA-Z0-9_\u4e00-\u9fa5 ]+\.(docx|pdf|xlsx|txt|jpg|pptx|png|doc|xls))') {
            $matched = $Matches[1].Trim()
            # 过滤掉一些系统级的无效字符
            return $matched -replace '[\\\/\:\*\?\"\<\>\|]', ''
        }
    } catch { }
    return $null
}

function Get-FileFormat($Path) {
    try {
        $b = [System.IO.File]::ReadAllBytes($Path)
        if ($b.Length -lt 4) { return "UNKNOWN" }
        if ($b[0] -eq 0x50 -and $b[1] -eq 0x4B) { return "XPS" }
        if ($b[0] -eq 0x25 -and $b[1] -eq 0x21) { return "PS" }
        return "PCL"
    } catch { return $null }
}

function Convert-Task($SplPath, $ShdPath, $JobId) {
    # 优先获取原始文件名，拿不到再用 ID 代替
    $docName = Get-OriginalName $ShdPath
    if (!$docName) { $docName = $JobId }
    
    $ts  = Get-Date -Format "HHmm"
    $out = Join-Path $DestFolder "$docName-$ts.pdf"
    $tmp = Join-Path $WorkDir "temp_$JobId.spl"

    try { Copy-Item $SplPath $tmp -Force -ErrorAction Stop } catch { return $false }

    $fmt = Get-FileFormat $tmp
    $engine = switch ($fmt) { "XPS" { $GXPS_Path }; "PS" { $GS_Path }; "PCL" { $GPL_Path }; default { $null } }

    if ($null -ne $engine -and (Test-Path $engine)) {
        $args = "-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFFitPage -dFIXEDMEDIA -sOutputFile=`"$out`" `"$tmp`""
        try {
            $p = Start-Process -FilePath $engine -ArgumentList $args -WindowStyle Hidden -PassThru -Wait
            if ($p.ExitCode -eq 0 -and (Test-Path $out)) {
                Remove-Item $tmp -Force -ErrorAction SilentlyContinue
                Write-Log "[SUCCESS] 已捕获: $docName"
                return $true
            }
        } catch { }
    }
    
    if (Test-Path $tmp) { Move-Item $tmp (Join-Path $DestFolder "$docName-$ts.RAW_SPL") -Force; return $true }
    return $false
}

Write-Log "===== 智能重命名版启动 ====="

while($true) {
    try {
        $currentFiles = Get-ChildItem $WatchPath -Filter *.shd -ErrorAction SilentlyContinue
        $currentJobNames = $currentFiles | ForEach-Object { $_.BaseName }

        # 清理已消失的任务
        $keys = $ProcessedJobs.Keys | ForEach-Object { $_ }
        foreach ($key in $keys) {
            if ($currentJobNames -notcontains $key) { $ProcessedJobs.Remove($key) }
        }

        foreach ($s in $currentFiles) {
            $jobId = $s.BaseName
            if (!$ProcessedJobs.ContainsKey($jobId)) {
                $spl = Join-Path $WatchPath ($jobId + ".spl")
                if (Test-Path $spl) {
                    if (Convert-Task $spl $s.FullName $jobId) {
                        $ProcessedJobs[$jobId] = $true
                    }
                }
            }
        }
    } catch { Write-Log "[FATAL] $_" }
    Start-Sleep -Milliseconds 800
}