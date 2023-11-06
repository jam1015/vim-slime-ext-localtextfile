
function! SlimeFooPluginConfig(config)
  if !exists("a:config['foo']")
    let a:config["foo"] = {"file": "foo.txt"}
  end
  let a:config["foo"]["file"] = input("Target file: ", a:config["foo"]["file"])
  return a:config
endfunction

function! SlimeFooPluginValidateEnv()
    let textFiles = glob('./*.txt')
    if textFiles == ''
        echo "No text files in current directory."
        return 0
    else
        return 1
    endif
endfunction


function! SlimeFooPluginValidateConfig(config)
    if filereadable(a:config["foo"]["file"])
        return 1
    else
        echom "File does not exist. Config invalid. Use :SlimeConfig to Reconfigure."
        return 0
    endif
endfunction


function! SlimeFooPluginSend(config, text)
  let l:file = a:config["foo"]["file"]
  return system("cat >> " . shellescape(file), a:text) 
endfunction



let g:slime_target_send="SlimeFooPluginSend"
let g:slime_target_config="SlimeFooPluginConfig"
let g:slime_valid_env="SlimeFooPluginValidateEnv"
let g:slime_valid_config="SlimeFooPluginValidateConfig"



map gz <Plug>SlimeMotionSend
map gzz <Plug>SlimeLineSend
xmap gz <Plug>SlimeRegionSend
