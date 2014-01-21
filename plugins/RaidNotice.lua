local RaidNoticeAddMessage = RaidNotice_AddMessage
function RaidNotice_AddMessage(noticeFrame, textString, colorInfo, displayTime)
  return RaidNoticeAddMessage(noticeFrame, textString and textString:gsub(':12:12', ':0:0:0:0:64:64:5:59:5:59'), colorInfo, displayTime)
end