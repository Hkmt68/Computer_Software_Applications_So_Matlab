ports = instrfind;
if ~isempty(ports)
    fclose(ports);
    delete(ports);
end

