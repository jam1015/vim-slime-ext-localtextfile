
function! SlimeFooPluginConfig(config)
  if !exists("a:config['foo']")
    let a:config["foo"] = {"file": "foo.txt"}
  end
  let a:config["foo"]["file"] = input("Target file: ", a:config["foo"]["file"])
  return a:config
endfunction



function! SlimeFooPluginSend(config, text)
  let l:file = a:config["foo"]["file"]
  return system("cat >> " . shellescape(file), a:text) 
endfunction



let g:slime_target_send="SlimeFooPluginSend"
let g:slime_target_config="SlimeFooPluginConfig"



map gz <Plug>SlimeMotionSend
map gzz <Plug>SlimeLineSend
xmap gz <Plug>SlimeRegionSend
