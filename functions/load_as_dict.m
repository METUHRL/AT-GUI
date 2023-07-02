function d = load_as_dict(struct_data)
    [container,fnames] = load_content(struct_data,0);
    d = dictionary(string(fnames),container);
end