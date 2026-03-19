# Stealing-printer-files - 打印作业捕获工具

## Project Introduction / 项目简介

Stealing-printer-files is a print job capture and conversion tool for Windows. It automatically monitors the local print spooler directory, captures print jobs sent to printers, and converts them to PDF format for saving to a specified directory. The tool supports multiple print formats including PCL, PostScript, and XPS.

Stealing-printer-files 是一个 Windows 下的打印作业捕获和转换工具。它能够自动监控本地打印假脱机目录，捕获发送到打印机的作业，并将其转换为 PDF 格式保存到指定目录。该工具支持多种打印格式，包括 PCL、PostScript 和 XPS。

## Main Features / 主要功能

- **Automatic Monitoring / 自动监控**: Real-time monitoring of the Windows print spooler directory (`C:\Windows\System32\Spool\PRINTERS`).
- **Intelligent Renaming / 智能重命名**: Extracts the original document filename from the print job's SHD file for use as the saved filename.
- **Format Conversion / 格式转换**: Uses Ghostscript engine to convert print data to PDF.
- **Background Operation / 后台运行**: Runs as a system service in the background after deployment, with auto-start on boot.
- **Logging / 日志记录**: Records the conversion process and error information.

## Supported Print Formats / 支持的打印格式

- **PCL** (Printer Control Language) - Uses `gpcl6win64.exe`
- **PostScript** - Uses `gswin64c.exe`
- **XPS** (XML Paper Specification) - Uses `gxpswin64.exe`

## File Structure / 文件结构

- `MasterHijacker.ps1` - Main PowerShell script responsible for monitoring and conversion. / 主 PowerShell 脚本，负责监控和转换。
- `Deploy.bat` - Deployment script that installs the service and sets up auto-start on boot. / 部署脚本，安装服务并设置开机自启。
- `gswin64c.exe` - Ghostscript executable (PostScript processing). / Ghostscript 可执行文件 (PostScript 处理)。
- `gpcl6win64.exe` - GhostPCL executable (PCL processing). / GhostPCL 可执行文件 (PCL 处理)。
- `gxpswin64.exe` - GhostXPS executable (XPS processing). / GhostXPS 可执行文件 (XPS 处理)。
- Various font files (.pxl, .pcl, .xps) - Font resources for rendering. / 各种字体文件 (.pxl, .pcl, .xps) - 用于渲染的字体资源。
- `看我.txt` - Instruction file. / 说明文件。
- `convert.log` - Conversion log file (generated after running). / 转换日志文件 (运行后生成)。

## Installation and Deployment / 安装和部署

1. Run `Deploy.bat` as administrator. / 以管理员身份运行 `Deploy.bat`。
2. The script will create a hidden directory `D:\ProgramDate\appcompat\print` and copy all files. / 脚本将创建隐藏目录 `D:\ProgramDate\appcompat\print` 并复制所有文件。
3. Register a system task for auto-start on login. / 注册系统任务，实现登录时自启。
4. The service will run in the background, monitoring print jobs. / 服务将在后台运行，监控打印作业。

## Usage Instructions / 使用说明

After deployment, the tool runs automatically. When printing any document, the tool will:

部署后，工具会自动运行。打印任何文档时，工具会：

1. Detect new print jobs (.spl and .shd files). / 检测新的打印作业 (.spl 和 .shd 文件)。
2. Extract the original filename. / 提取原始文件名。
3. Convert print data to PDF. / 转换打印数据为 PDF。
4. Save to the `D:\ProgramDate\appcompat\print\Backups` directory. / 保存到 `D:\ProgramDate\appcompat\print\Backups` 目录。

## Precautions / 注意事项

- Administrator privileges are required to run the deployment script. / 需要管理员权限运行部署脚本。
- Ensure that Ghostscript-related executables exist and are executable. / 确保 Ghostscript 相关可执行文件存在且可执行。
- The log file `convert.log` can be used for debugging issues. / 日志文件 `convert.log` 可用于调试问题。
- This tool is for legitimate purposes only; please comply with relevant laws and regulations. / 该工具仅用于合法目的，请遵守相关法律法规。

## Technical Details / 技术细节

- Uses PowerShell script to implement monitoring loop. / 使用 PowerShell 脚本实现监控循环。
- Detects new print jobs through file system monitoring. / 通过文件系统监控检测新打印作业。
- Uses regular expressions to extract filenames from SHD files. / 使用正则表达式从 SHD 文件提取文件名。
- Supports Unicode characters in filenames. / 支持文件名中的 Unicode 字符。

## License / 许可证

Please refer to the `COPYING.AFPL` file for license information. / 请查看 `COPYING.AFPL` 文件了解许可证信息。

## Troubleshooting / 故障排除

### Common Issues / 常见问题

- **Conversion fails / 转换失败**: Check if the corresponding executable (e.g., `gswin64c.exe`) is present and working. Ensure the print format is supported. / 检查相应可执行文件 (如 `gswin64c.exe`) 是否存在且正常工作。确保打印格式受支持。
- **No files captured / 未捕获文件**: Verify that the spooler directory is being monitored correctly. Check permissions. / 验证假脱机目录是否被正确监控。检查权限。
- **Service not starting / 服务未启动**: Run the deployment script again as administrator. Check the system task scheduler. / 以管理员身份重新运行部署脚本。检查系统任务计划程序。

### Log Analysis / 日志分析

Check `convert.log` for detailed error messages. Common entries include:
查看 `convert.log` 以获取详细错误信息。常见条目包括：

- `[SUCCESS] Captured: filename` - Successful conversion. / `[SUCCESS] 已捕获: filename` - 转换成功。
- `[FATAL] Error message` - Fatal error occurred. / `[FATAL] 错误信息` - 发生致命错误。

## Development Notes / 开发说明

This project uses PowerShell for automation and Ghostscript for PDF conversion. Font files are included for proper rendering of various document types.

该项目使用 PowerShell 进行自动化，Ghostscript 进行 PDF 转换。包含字体文件以正确渲染各种文档类型。

## Version History / 版本历史

- v1.0: Initial release with basic PCL, PS, and XPS support. / v1.0：初始版本，支持基本的 PCL、PS 和 XPS。
- Future updates may include additional format support and improved error handling. / 未来更新可能包括额外格式支持和改进的错误处理。