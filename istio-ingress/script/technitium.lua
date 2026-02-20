function envoy_on_request(request_handle)
  local authority = request_handle:headers():get(":authority")
  if authority ~= "dns.lth.so" and authority ~= "dns.limtaehyun.dev" then
    return
  end

  local path = request_handle:headers():get(":path")
  if path == nil then
    return
  end

  local path_only = string.match(path, "^([^?]*)")
  if path_only ~= "/api/user/login" then
    return
  end

  local body = request_handle:body()
  if body == nil then
    return
  end

  body:setBytes("<form-data>")
  request_handle:headers():replace("content-type", "application/x-www-form-urlencoded")
end
