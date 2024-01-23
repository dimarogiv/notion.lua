go_search_result = function(res)
  write_log([[listtogo[res] = ]] .. listtogo[res])
  local path = vim.fn.split(listtogo[res], ":\\t")[1]
  write_log([[path = ]] .. path)
  if string.sub(path, 1, 1) == '/' then
    wgo_to_note(root .. path)
  else
    wgo_to_note(root)
  end
  vim.fn.setpos(".", {0, vim.fn.search(pattern), 0, true})
  if vim.fn.line(".") < vim.fn.line("$") then
    vim.cmd.normal("k")
  end
end

search_note = function(search_root)
  vim.fn.inputsave()
  pattern = vim.fn.input("Search: ")
  vim.fn.inputrestore()
  list = vim.fn.systemlist("grep -R --exclude='.*' \'" .. pattern .. "\' " .. search_root .. " 2>&1 | grep -v 'grep:' | sed 's/\\/_:/:\\t\\t/'")
  if #list == 0 then
    return
  end
  listtogo = list
  local listtoshow = list
  for item=1,#listtoshow,1 do
    listtoshow[item] = vim.fn.split(list[item], root)[1]
  end
  popup_menu_create(listtoshow)
end